# Dream Vacation App - CI/CD Pipeline Documentation

This project features fully automated Continuous Integration and Continuous Deployment (CI/CD) workflows powered by GitHub Actions.

## CI/CD Architecture
The pipeline is split into two independent workflows to optimize build performance and enforce modularity:
1. **Frontend Workflow (`.github/workflows/frontend.yml`)**: Monitored via path filters; executes exclusively when changes are introduced to files inside the `frontend/` directory.
2. **Backend Workflow (`.github/workflows/backend.yml`)**: Monitored via path filters; executes exclusively when changes are introduced to files inside the `backend/` directory.

### Pipeline Stages
Each workflow utilizes a multi-stage configuration:
* **Stage 1: Lint & Test (CI):** Installs project dependencies securely via `npm install`, then executes code linting (`npm run lint`) and runtime unit checks (`npm test`) to guarantee stability.
* **Stage 2: Build & Push (CD):** Triggered strictly on branch pushes or completed merges to `main` or `dev`. Authenticates securely to Docker Hub and compiles production-ready container images before uploading them.

## Container Registry Tagging
Images are pushed to Docker Hub and uniquely tagged using two distinct markers:
* `:latest` - Tracks the most up-to-date deployment build.
* `:${{ github.sha }}` - Tracks the precise git commit SHA for version tracing and deployment rollbacks.

## Required Environment Secrets
To run successfully, the repository requires the following GitHub Secrets configured:
* `DOCKER_USERNAME` - Your Docker Hub profile handle.
* `DOCKER_TOKEN` - A valid Personal Access Token generated via Docker Hub settings.
