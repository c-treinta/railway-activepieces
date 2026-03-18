RAILWAY_PROJECT ?= templates-test
ENCRYPTION_KEY ?= $(shell openssl rand -hex 16)
JWT_SECRET ?= $(shell openssl rand -hex 32)

deploy:
	railway link -p $(RAILWAY_PROJECT)
	railway add --database postgres
	railway add --database redis
	railway add --service activepieces-app
	railway up app --path-as-root --service activepieces-app
	railway variable set --service activepieces-app \
	  PORT=80 \
	  AP_NODE_ENVIRONMENT=production \
	  AP_ENCRYPTION_KEY=$(ENCRYPTION_KEY) \
	  AP_JWT_SECRET=$(JWT_SECRET) \
	  'AP_POSTGRES_DATABASE=$${{Postgres.PGDATABASE}}' \
	  'AP_POSTGRES_HOST=$${{Postgres.PGHOST}}' \
	  'AP_POSTGRES_PORT=$${{Postgres.PGPORT}}' \
	  'AP_POSTGRES_USERNAME=$${{Postgres.PGUSER}}' \
	  'AP_POSTGRES_PASSWORD=$${{Postgres.PGPASSWORD}}' \
	  'AP_REDIS_URL=$${{Redis.REDIS_URL}}' \
	  'AP_FRONTEND_URL=https://$${{RAILWAY_PUBLIC_DOMAIN}}'

destroy:
	@echo "Delete services via Railway dashboard: activepieces-app, Postgres, Redis"
	@echo "https://railway.com/project/$(RAILWAY_PROJECT)"

status:
	railway service status --all --json

logs:
	railway logs --service activepieces-app --lines 100

.PHONY: deploy destroy status logs
