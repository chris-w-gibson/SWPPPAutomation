import os
import subprocess

import psycopg2
import pytest
from testcontainers.postgres import PostgresContainer


@pytest.fixture(scope="session")
def pg_container():
    with PostgresContainer("postgres:16-alpine") as postgres:
        yield postgres


@pytest.fixture(scope="session")
def pg_conn(pg_container):
    url = pg_container.get_connection_url()
    env = os.environ.copy()
    env["DATABASE_URL"] = url
    subprocess.run(["./migrate.sh"], check=True, env=env)
    conn = psycopg2.connect(url)
    yield conn
    conn.close()

