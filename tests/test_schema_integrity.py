import os
import psycopg2
import pytest

TABLE_COLUMNS = {
    'contractors': ['contractor_id', 'name', 'contact_info', 'rating'],
    'projects': ['project_id', 'name', 'owner', 'general_contractor_id', 'latitude', 'longitude', 'acres',
                'jurisdiction', 'status', 'inspection_cadence', 'created_at'],
    'lots': ['lot_id', 'project_id', 'lot_number', 'schedule', 'created_at'],
    'renewal_rules': ['rule_id', 'jurisdiction', 'lead_time_days', 'permit_language'],
    'dates': ['date', 'year', 'month', 'day', 'quarter', 'week'],
    'inspections': ['inspection_id', 'project_id', 'inspection_date', 'inspector', 'severity', 'findings',
                    'photo_url', 'report_url', 'created_at'],
    'tasks': ['task_id', 'project_id', 'description', 'created_at', 'due_date', 'completed_at', 'sla'],
    'versions': ['version_id', 'project_id', 'version_number', 'file_sha256', 'envelope_id', 'signed_at', 'created_at'],
}


def table_exists(cur, table_name):
    cur.execute("SELECT to_regclass(%s)", (table_name,))
    return cur.fetchone()[0] is not None


def column_exists(cur, table_name, column_name):
    cur.execute(
        """
        SELECT 1
        FROM information_schema.columns
        WHERE table_name = %s AND column_name = %s
        """,
        (table_name, column_name),
    )
    return cur.fetchone() is not None


def test_schema_integrity():
    db_url = os.environ.get('DATABASE_URL')
    assert db_url, 'DATABASE_URL environment variable must be set for tests'
    with psycopg2.connect(db_url) as conn:
        with conn.cursor() as cur:
            for table, columns in TABLE_COLUMNS.items():
                assert table_exists(cur, table), f"Table {table} is missing"
                for column in columns:
                    assert column_exists(cur, table, column), f"Column {table}.{column} is missing"
