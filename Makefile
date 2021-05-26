node_modules:
	docker-compose -f docker-compose.development.yml run api npm install

development: node_modules
	docker-compose -f docker-compose.development.yml up

docker-build:
	docker build -t 080953414563.dkr.ecr.eu-west-3.amazonaws.com/unotifier:latest .

docker-push:
	aws ecr get-login-password --region eu-west-3 | docker login --username AWS --password-stdin 080953414563.dkr.ecr.eu-west-3.amazonaws.com
	docker push 080953414563.dkr.ecr.eu-west-3.amazonaws.com/unotifier:latest

docker-pull:
	aws ecr get-login-password --region eu-west-3 | docker login --username AWS --password-stdin 080953414563.dkr.ecr.eu-west-3.amazonaws.com
	docker pull 080953414563.dkr.ecr.eu-west-3.amazonaws.com/unotifier:latest

production:
	docker-compose -f docker-compose.production.yml up -d --force-recreate
	docker-compose -f docker-compose.production.yml run api npm run prisma:migrate

# DANGER-production-prisma-studio:
# 	docker-compose -p 5555:5555 -f docker-compose.production.yml run api npm run prisma:studio

prisma-introspect:
	docker-compose -f docker-compose.development.yml run api npm run prisma:introspect

prisma-generate:
	docker-compose -f docker-compose.development.yml run api npm run prisma:generate

prisma-migrate:
	docker-compose -f docker-compose.development.yml run api npm run prisma:migrate

prisma-migrate-reset:
	docker-compose -f docker-compose.development.yml run api npm run prisma:migrate-reset

prisma-fixtures:
	docker-compose -f docker-compose.development.yml exec api npm run prisma:migrate-reset
	docker-compose -f docker-compose.development.yml exec api node build/fixtures.js

psql:
	docker-compose -f docker-compose.development.yml exec db psql -h localhost -d postgres -U postgres
