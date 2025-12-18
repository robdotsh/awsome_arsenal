import boto3
import csv
from json import loads
import psycopg2
from random import choices
from string import ascii_letters, digits
from os import getenv


INPUT_FILE = getenv("DB_LIST")
RO_USERNAME = "percona_ro_user"
user_created = False

# create output file
OUTPUT_FILENAME = INPUT_FILE.strip(".csv") + "_ro_users.csv"
with open(OUTPUT_FILENAME, "w") as outfile:
    outfile_writer = csv.writer(outfile)
    outfile_writer.writerow(["db_url", "db_name", "region", "username", "password"])

# create secrets manager session and client
session = boto3.session.Session(region_name="us-east-1")
client = session.client("secretsmanager")


with open(INPUT_FILE, "r") as file:
    reader = csv.DictReader(file)

    for row in reader:
        # create alphanumeric password that's URI-compatible
        # https://stackoverflow.com/questions/2511222/efficiently-generate-a-16-character-alphanumeric-string
        ro_pass = "".join(choices(ascii_letters + digits, k=20))

        # keeping the f-string query in-scope to access column keys in row
        user_creation_query = (
            f"CREATE USER {RO_USERNAME} WITH PASSWORD '{ro_pass}'; "
            + f"GRANT CONNECT ON DATABASE {row['db_name']} TO {RO_USERNAME}; "
            + f"GRANT SELECT ON ALL TABLES IN SCHEMA public TO {RO_USERNAME}; "
            + f"ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO {RO_USERNAME};"
        )

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

            # create user
            cursor = connection.cursor()
            cursor.execute(user_creation_query)
            cursor.execute(
                f"select * from pg_catalog.pg_user where usename = '{RO_USERNAME}';"
            )
            record = cursor.fetchall()
            cursor.close()
            connection.close()
            user_created = True
            print(f"user {RO_USERNAME} created in {row['db_url']}")

        except KeyError as e:
            print(
                f"error getting db password for {row['db_url']}, double-check password_key"
            )
        except psycopg2.errors.DuplicateObject as e:
            print(f"error creating user on {row['db_url']}: {e}")
        except Exception as e:
            print(f"hit an error on {row['db_url']}: {e}")

        # write new user details to csv
        if user_created:
            with open(OUTPUT_FILENAME, "a") as outfile:
                dict_writer = csv.writer(outfile)
                dict_writer.writerow(
                    [
                        row["db_url"],
                        row["db_name"],
                        row["region"],
                        RO_USERNAME,
                        ro_pass,
                    ]
                )
