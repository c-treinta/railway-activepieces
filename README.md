# Activepieces

[![Deploy on Railway](https://railway.app/button.svg)](https://railway.app/new/template?template=https://github.com/c-treinta/railway-activepieces)

Open-source automation platform (n8n alternative).

**Services:** `activepieces-app`, `Postgres`, `Redis` (Railway-managed)

## Deploy

```bash
make deploy
# ENCRYPTION_KEY and JWT_SECRET are auto-generated
```

## Environment Variables (auto-wired)

| Variable | Description |
|----------|-------------|
| `AP_ENCRYPTION_KEY` | Auto-generated 16-byte hex key |
| `AP_JWT_SECRET` | Auto-generated 32-byte hex secret |
| `AP_POSTGRES_DATABASE_URL` | Railway reference to `Postgres` |
| `AP_REDIS_URL` | Railway reference to `Redis` |
