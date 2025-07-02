-- Schema for SWPPP automation database

CREATE TABLE IF NOT EXISTS contractors (
    contractor_id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    contact_info TEXT,
    rating NUMERIC
);

CREATE TABLE IF NOT EXISTS projects (
    project_id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    owner TEXT NOT NULL,
    general_contractor_id INTEGER REFERENCES contractors(contractor_id),
    latitude NUMERIC(9,6),
    longitude NUMERIC(9,6),
    acres NUMERIC(10,2),
    jurisdiction TEXT,
    status TEXT,
    inspection_cadence INTEGER,
    created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS lots (
    lot_id SERIAL PRIMARY KEY,
    project_id INTEGER REFERENCES projects(project_id) ON DELETE CASCADE,
    lot_number TEXT,
    schedule TEXT,
    created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS dates (
    date DATE PRIMARY KEY,
    year INTEGER,
    month INTEGER,
    day INTEGER,
    quarter INTEGER,
    week INTEGER
);

CREATE TABLE IF NOT EXISTS dates (
    date DATE PRIMARY KEY,
    year INTEGER,
    month INTEGER,
    day INTEGER,
    quarter INTEGER,
    week INTEGER
);

CREATE TABLE IF NOT EXISTS inspections (
    inspection_id SERIAL PRIMARY KEY,
    project_id INTEGER REFERENCES projects(project_id) ON DELETE CASCADE,
    inspection_date TIMESTAMP WITHOUT TIME ZONE NOT NULL,
    inspector TEXT,
    severity TEXT,
    findings TEXT,
    photo_url TEXT,
    report_url TEXT,
    created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS tasks (
    task_id SERIAL PRIMARY KEY,
    project_id INTEGER REFERENCES projects(project_id) ON DELETE CASCADE,
    description TEXT NOT NULL,
    created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW(),
    due_date TIMESTAMP WITHOUT TIME ZONE,
    completed_at TIMESTAMP WITHOUT TIME ZONE,
    sla BOOLEAN DEFAULT FALSE
);

CREATE TABLE IF NOT EXISTS versions (
    version_id SERIAL PRIMARY KEY,
    project_id INTEGER REFERENCES projects(project_id) ON DELETE CASCADE,
    version_number INTEGER NOT NULL,
    file_sha256 CHAR(64) NOT NULL,
    envelope_id TEXT,
    signed_at TIMESTAMP WITHOUT TIME ZONE,
    created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW()
);

