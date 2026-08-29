#!/bin/bash

set -e

LOG_DIR="${LOG_DIR:-logs}"
MAX_LOGS="${MAX_LOGS:-5}"

mkdir -p "$LOG_DIR"

find "$LOG_DIR" -type f -name "*.log" -exec gzip -f {} \;

find "$LOG_DIR" -type f -name "*.gz" -printf '%T@ %p\n' |
    sort -nr |
    tail -n +$((MAX_LOGS + 1)) |
    cut -d' ' -f2- |
    xargs -r rm -f

echo "Log rotation completed successfully."
