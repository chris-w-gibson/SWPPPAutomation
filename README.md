# SWPPP Automation Database

This project contains the base PostgreSQL schema and utilities for SWPPP automation.

## Requirements
- PostgreSQL client (`psql`)
- Python 3 with `pip`

Install Python dependencies:

```bash
pip install -r requirements.txt
```

## Database Setup
Run migrations using the helper script. Provide a database connection URL either via the `DATABASE_URL` environment variable or as the first argument.

```bash
export DATABASE_URL=postgres://user:pass@localhost/dbname
./migrate.sh
```

### Renewal Rules
The `renewal_rules` table stores jurisdiction specific renewal defaults.

```sql
CREATE TABLE IF NOT EXISTS renewal_rules (
    jurisdiction       VARCHAR(2) PRIMARY KEY,
    permit_code        VARCHAR(15) NOT NULL,
    lead_time_days     INT NOT NULL,
    auto_terminate_yrs INT NOT NULL,
    rule_ref_url       TEXT NOT NULL,
    last_revised       DATE NOT NULL
);
```

Add a new state with an `INSERT` similar to:

```sql
INSERT INTO renewal_rules (jurisdiction, permit_code, lead_time_days,
                           auto_terminate_yrs, rule_ref_url, last_revised)
VALUES ('XX', 'ABC123456', 60, 5, 'https://example.com/permit', '2024-01-01');
```

Typical lead-time values range from 30–90 days depending on the permit. For more permit codes see the [EPA permit index](https://www.epa.gov/npdes/stormwater-discharges-construction-activities#permits).

## Running Tests
Tests spin up a temporary PostgreSQL container and apply migrations automatically.

```bash
pytest
```

## Populate Project Variables
Use the provided script to generate the Excel workbook that business users fill out.

```bash
python tools/generate_variable_template.py --out templates/variable_template.xlsx
```

Pass `--force` to overwrite an existing file. The workbook contains two sheets:

- **Projects** — main project details. Only replace the yellow cells; green cells are auto-filled post-merge.
- **Lots** — optional per-lot scheduling information.

Each column corresponds to a merge variable. `Inspection_Freq` accepts `7-day`, `14-day`, or `Other`.

The template is ignored from version control; regenerate it whenever the schema changes.
