# Dream Vacation Destinations

[![CI](https://github.com/joe-dan-efik/Dream-Vacation-App/actions/workflows/ci.yml/badge.svg)](https://github.com/joe-dan-efik/Dream-Vacation-App/actions)
[![CD](https://github.com/joe-dan-efik/Dream-Vacation-App/actions/workflows/cd.yml/badge.svg)](https://github.com/joe-dan-efik/Dream-Vacation-App/actions)

🌐 **Live Application:** [https://dreamvacations-app.online](https://dreamvacations-app.online)

---

## Project Overview
This application is a full-stack travel and vacation booking platform built with **React**, **Node.js/Express**, and **PostgreSQL**. The complete DevOps lifecycle is automated using Docker multi-stage containerization, GitHub Actions CI/CD pipelines, Terraform Infrastructure as Code (IaC), and an Nginx reverse proxy secured with Let's Encrypt SSL on AWS EC2.

---

## Architecture

```mermaid
flowchart TD
    User([User Browser]) -->|HTTPS / 443| DNS[AWS Route 53]
    DNS --> Nginx[Nginx Reverse Proxy + Let's Encrypt SSL]
    Nginx -->|Port 3000| Frontend[React Frontend Container]
    Nginx -->|Port 5000 /api| Backend[Node.js / Express Backend Container]
    Backend -->|Port 5432| DB[(PostgreSQL Database Container)]
