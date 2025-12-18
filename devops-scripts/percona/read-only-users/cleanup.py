import boto3
import csv
from json import loads
import psycopg2
from os import getenv


INPUT_FILE = getenv("DB_LIST")
RO_USERNAME = "percona_ro_user"
user_created = False

# create secrets manager session and client
session = boto3.session.Session(region_name="us-east-1")
client = session.client("secretsmanager")


with open(INPUT_FILE, "r") as file:
    reader = csv.DictReader(file)

    for row in reader:

        # keeping the f-string query in-scope to access column keys in row
        revoke_tables = f"REVOKE ALL ON ALL TABLES IN schema public from {RO_USERNAME};"
        alter_default_privilages = f"ALTER DEFAULT PRIVILEGES IN SCHEMA public REVOKE SELECT, INSERT, UPDATE, DELETE ON TABLES FROM {RO_USERNAME};"
        revoke_privilages = (
            f"REVOKE ALL PRIVILEGES ON DATABASE {row['db_name']} from {RO_USERNAME};"
        )
        drop_user = f"DROP USER {RO_USERNAME};"

        try:
            # get secret from SecretsManager
            # this is ugly and has to be done because SecretString is actually a
            # string that contains key/value pairs :grimace:
            db_pass = loads(
                client.get_secret_value(SecretId=row["password_path"])["SecretString"]
            )[row["password_key"]]

            # connect to db
            connection = psycopg2.connect(
                user=row["username"],
                password=db_pass,
                host=row["db_url"],
                port="5432",
                database=row["db_name"],
            )
            connection.autocommit = True

            # delete user
            cursor = connection.cursor()
            cursor.execute(revoke_tables)
            cursor.execute(alter_default_privilages)
            cursor.execute(revoke_privilages)
            cursor.execute(drop_user)
            cursor.close()
            connection.close()
            print(f"{RO_USERNAME} dropped from {row['db_url']}")

        except BaseException as e:
            print(f"hit an error on {row['db_url']}: {e}")
