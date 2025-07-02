CREATE TABLE IF NOT EXISTS renewal_rules (
    jurisdiction       VARCHAR(2)  PRIMARY KEY,
    permit_code        VARCHAR(15) NOT NULL,
    lead_time_days     INT         NOT NULL,
    auto_terminate_yrs INT         NOT NULL,
    rule_ref_url       TEXT        NOT NULL,
    last_revised       DATE        NOT NULL
);
