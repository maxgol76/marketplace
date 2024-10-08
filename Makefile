# Define project variables
PROJECT_NAME=laravel-app
DOCKER_COMPOSE=docker-compose
DOCKER_DIR=./docker

# Docker commands
up:
	$(DOCKER_COMPOSE) up -d

build:
	$(DOCKER_COMPOSE) up --build -d

down:
	$(DOCKER_COMPOSE) down

restart:
	$(DOCKER_COMPOSE) down && $(DOCKER_COMPOSE) up -d

logs:
	$(DOCKER_COMPOSE) logs -f

# Run Composer inside Docker container
composer-install:
	docker run --rm -v $(PWD):/var/www/html -w /var/www/html $(PROJECT_NAME)-app composer install

# Xdebug toggle (example of enabling/disabling Xdebug)
xdebug-on:
	$(DOCKER_COMPOSE) exec -T app bash -c "echo 'zend_extension=xdebug.so' >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini && pkill -o -USR2 php-fpm"

xdebug-off:
	$(DOCKER_COMPOSE) exec -T app bash -c "rm /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini && pkill -o -USR2 php-fpm"

# Database commands
db-migrate:
	$(DOCKER_COMPOSE) exec app php artisan migrate

db-seed:
	$(DOCKER_COMPOSE) exec app php artisan db:seed

# PHPUnit inside Docker container
test:
	$(DOCKER_COMPOSE) exec app ./vendor/bin/phpunit

# Clean up unused Docker images and containers
clean:
	docker system prune -a --volumes
