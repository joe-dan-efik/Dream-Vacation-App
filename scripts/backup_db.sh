#!/bin/bash

set -e

echo "Starting database backup..."

if [ -z "$DATABASE_URL" ]; then
    echo "Error: DATABASE_URL is not set."
    exit 1
fi

if ! command -v pg_dump >/dev/null 2>&1; then
    echo "Error: pg_dump is not installed."
    exit 1
fi

BACKUP_DIR="backups"
mkdir -p "$BACKUP_DIR"

TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_FILE="$BACKUP_DIR/dream_vacations_$TIMESTAMP.sql"

pg_dump "$DATABASE_URL" > "$BACKUP_FILE"

echo "Database backup completed:"
echo "$BACKUP_FILE"
