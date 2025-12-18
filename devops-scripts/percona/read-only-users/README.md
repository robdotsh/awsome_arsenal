# read-only-users

Create (you guessed it) read-only users for Percona

## Development
This project uses [`poetry`](https://python-poetry.org/docs/basic-usage/) to
handle dependencies, and is designed to be executed locally.

Once you've installed `poetry`, run `poetry install` to install the
dependencies, and run `poetry shell` to start a corresponding environment.

## Usage
1. Auth to AWS (I like the `AWS_PROFILE` env var to make life easier :shrug:)
1. Make sure you're connected to the VPN (currently only Pritunl works)
1. The hard and tedious part: populate your input file (see [`readOnly.csv`](readOnly.csv) as a reference)
1. Run `DB_LIST="path/to/input/file" python read_only_users.py`

    sample execution:

    ``` bash
    DB_LIST="readOnly.csv" python read_only_users.py
    user percona_ro_user created in localhost
    ```

1. View your output in `$INPUT_FILE_ro_users.csv`


