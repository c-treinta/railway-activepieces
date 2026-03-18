# Deploy and Host Activepieces on Railway

[![Deploy on Railway](https://railway.com/button.svg)](https://railway.com/new/template/activepieces-1)

Activepieces is an open-source no-code automation platform that lets you connect apps and automate workflows without writing code. It is a self-hostable alternative to Zapier and Make, built with TypeScript and designed for both individuals and teams.

## About Hosting Activepieces

Hosting Activepieces on Railway gives you a fully managed deployment of the automation platform backed by a PostgreSQL database and Redis instance. Railway handles networking, environment wiring, and restarts automatically. The Activepieces container runs on port 80, connects to Postgres for persistent workflow storage, and uses Redis for background job queuing. Encryption keys and JWT secrets are auto-generated on first deploy so your instance is secure out of the box. You retain full control over your data and automation logic.

## Common Use Cases

- Automating internal business workflows without writing backend code
- Syncing data between SaaS tools such as CRMs, spreadsheets, and messaging apps
- Triggering notifications and actions based on webhooks or scheduled events
- Building lightweight ETL pipelines for small-to-medium data volumes
- Replacing paid automation platforms with a self-hosted, cost-controlled alternative

## Dependencies for Activepieces Hosting

- PostgreSQL database (Railway-managed)
- Redis instance (Railway-managed)

### Deployment Dependencies

- Docker image: [activepieces/activepieces](https://hub.docker.com/r/activepieces/activepieces)
- Activepieces documentation: [https://www.activepieces.com/docs](https://www.activepieces.com/docs)

### Implementation Details

Environment variables are wired between services using Railway reference variables:

| Variable | Value |
|---|---|
| `AP_ENCRYPTION_KEY` | `${{secret(32, "abcdef0123456789")}}` — auto-generated 16-byte hex key |
| `AP_JWT_SECRET` | `${{secret(64, "abcdef0123456789")}}` — auto-generated 32-byte hex secret |
| `AP_POSTGRES_DATABASE` | `${{Postgres.PGDATABASE}}` |
| `AP_POSTGRES_HOST` | `${{Postgres.PGHOST}}` |
| `AP_POSTGRES_PORT` | `${{Postgres.PGPORT}}` |
| `AP_POSTGRES_USERNAME` | `${{Postgres.PGUSER}}` |
| `AP_POSTGRES_PASSWORD` | `${{Postgres.PGPASSWORD}}` |
| `AP_REDIS_URL` | `${{Redis.REDIS_URL}}` |
| `AP_FRONTEND_URL` | `https://${{RAILWAY_PUBLIC_DOMAIN}}` |

Health check is available at `/api/v1/health`.

## Why Deploy Activepieces on Railway?

Railway is a singular platform to deploy your infrastructure stack. Railway will host your infrastructure so you don't have to deal with configuration, while allowing you to vertically and horizontally scale it.

By deploying Activepieces on Railway, you are one step closer to supporting a complete full-stack application with minimal burden. Host your servers, databases, AI agents, and more on Railway.
