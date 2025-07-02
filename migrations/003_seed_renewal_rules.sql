INSERT INTO renewal_rules (jurisdiction, permit_code, lead_time_days,
                           auto_terminate_yrs, rule_ref_url, last_revised)
VALUES
    ('TX', 'TXR150000', 90, 5, 'https://www.tceq.texas.gov/...', '2023-05-15'),
    ('LA', 'LAR100000', 30, 5, 'https://deq.louisiana.gov/...', '2024-01-02')
ON CONFLICT (jurisdiction) DO UPDATE
SET permit_code = EXCLUDED.permit_code,
    lead_time_days = EXCLUDED.lead_time_days,
    auto_terminate_yrs = EXCLUDED.auto_terminate_yrs,
    rule_ref_url = EXCLUDED.rule_ref_url,
    last_revised = EXCLUDED.last_revised;
