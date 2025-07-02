import psycopg2


def test_tx_rule_present(pg_conn):
    cur = pg_conn.cursor()
    cur.execute(
        "SELECT lead_time_days FROM renewal_rules WHERE jurisdiction = 'TX';"
    )
    (days,) = cur.fetchone()
    assert days == 90


def test_la_rule_present(pg_conn):
    cur = pg_conn.cursor()
    cur.execute(
        "SELECT auto_terminate_yrs FROM renewal_rules WHERE jurisdiction = 'LA';"
    )
    (yrs,) = cur.fetchone()
    assert yrs == 5

