RAILWAY_PROJECT ?= templates-test
ENCRYPTION_KEY ?= $(shell openssl rand -hex 16)
JWT_SECRET ?= $(shell openssl rand -hex 32)

deploy:
	railway link -p $(RAILWAY_PROJECT)
	railway add --database postgres
	railway add --database redis
	railway add --service activepieces-app
	cd app && railway up --service activepieces-app
	railway variable set --service activepieces-app \
	  AP_NODE_ENVIRONMENT=production \
	  AP_ENCRYPTION_KEY=$(ENCRYPTION_KEY) \
	  AP_JWT_SECRET=$(JWT_SECRET) \
	  'AP_POSTGRES_DATABASE_URL=${{Postgres.DATABASE_URL}}' \
	  'AP_REDIS_URL=${{Redis.REDIS_URL}}'

destroy:
	@echo "Delete services via Railway dashboard: activepieces-app, Postgres, Redis"
	@echo "https://railway.app/project/$(RAILWAY_PROJECT)"

status:
	railway service status --all --json

logs:
	railway logs --service activepieces-app --lines 100

.PHONY: deploy destroy status logs
