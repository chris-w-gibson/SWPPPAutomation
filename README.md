# SWPPP Automation Database

This project contains the base PostgreSQL schema and utilities for SWPPP automation.

## Requirements
- PostgreSQL client (`psql`)
- Python 3 with `pip`

Install Python dependencies:

```bash
pip install -r requirements.txt
```

## Running Migrations
The schema lives in `migrations/schema.sql` and can be applied using `migrate.sh`.
Provide a database connection URL either via the `DATABASE_URL` environment variable or as the first argument.

```bash
export DATABASE_URL=postgres://user:pass@localhost/dbname
./migrate.sh
```

## Running Tests
Tests verify that all schema objects exist. The tests expect the database specified by `DATABASE_URL` to already have the schema applied.

```bash
pytest tests/test_schema_integrity.py
```
