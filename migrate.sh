#!/bin/bash
# Apply database migrations
# Usage: DATABASE_URL=postgres://user:pass@host/db ./migrate.sh

set -e

DB_URL="${1:-$DATABASE_URL}"
if [ -z "$DB_URL" ]; then
    echo "Error: provide database url as argument or set DATABASE_URL" >&2
    exit 1
fi

psql "$DB_URL" -f migrations/001_init.sql
