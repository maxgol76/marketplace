# Variables
DOCKER_COMPOSE = cd docker && docker-compose
DOCKER_EXEC = $(DOCKER_COMPOSE) exec app

# Default command: start the containers
up:
	$(DOCKER_COMPOSE) up -d

# Stop the containers
down:
	$(DOCKER_COMPOSE) down

# Run Laravel Artisan command
artisan:
	$(DOCKER_EXEC) php artisan $(CMD)

# Install Composer dependencies
composer-install:
	$(DOCKER_EXEC) composer install

# Run migrations
migrate:
	$(DOCKER_EXEC) php artisan migrate

# Run database seeder
seed:
	$(DOCKER_EXEC) php artisan db:seed

# Bring up containers and run migrations
setup: up composer-install migrate seed

# Access the container's shell
shell:
	$(DOCKER_EXEC) sh
