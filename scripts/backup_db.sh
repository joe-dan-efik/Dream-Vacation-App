#!/bin/bash

set -e

echo "Starting database backup..."

CONTAINER_NAME="dream-vacation-db"
DB_USER="dreamuser"
DB_NAME="dreamvacations"
BACKUP_DIR="backups"

mkdir -p "$BACKUP_DIR"

if ! docker ps --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"; then
    echo "Error: PostgreSQL container is not running."
    exit 1
fi

TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
BACKUP_FILE="$BACKUP_DIR/dream_vacations_$TIMESTAMP.sql"

docker exec "$CONTAINER_NAME" pg_dump \
    -U "$DB_USER" \
    -d "$DB_NAME" \
    > "$BACKUP_FILE"

echo "Database backup completed successfully:"
echo "$BACKUP_FILE"O

