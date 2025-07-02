#!/bin/bash
# Apply database migrations
# Usage: DATABASE_URL=postgres://user:pass@host/db ./migrate.sh

set -e

DB_URL="${1:-$DATABASE_URL}"
if [ -z "$DB_URL" ]; then
    echo "Error: provide database url as argument or set DATABASE_URL" >&2
    exit 1
fi

for file in $(ls migrations/*.sql | sort); do
    psql "$DB_URL" -f "$file"
done
