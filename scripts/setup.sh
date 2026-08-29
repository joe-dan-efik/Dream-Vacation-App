#!/bin/bash

set -e

echo "Starting environment setup..."

if ! command -v node >/dev/null 2>&1; then
    echo "Error: Node.js is not installed."
    exit 1
fi

if ! command -v npm >/dev/null 2>&1; then
    echo "Error: npm is not installed."
    exit 1
fi

echo "Node.js version: $(node --version)"
echo "npm version: $(npm --version)"

if [ ! -d "node_modules" ]; then
    echo "Installing dependencies..."
    npm install
else
    echo "Dependencies already installed. Skipping npm install."
fi

echo "Environment setup complete."
