DOCKER_COMPOSE = docker-compose
DOCKER_COMPOSE_FILE = srcs/docker-compose.yml
# DB_PATH = /home/rel-sima/data/db
# WORDPRESS_PATH = /home/rel-sima/data/wordpress

.PHONY: all build up down clean restart logs

all: build up

build:
	@echo "Building Docker images..."
	$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) build

up:
	@echo "Starting Docker containers..."
	$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) up -d

down:
	@echo "Stopping Docker containers..."
	$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) down

clean: down
	@echo "Removing Docker images and volumes..."
	$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) down --rmi all --volumes --remove-orphans

restart: down up

logs:
	@echo "Showing Docker container logs..."
	$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) logs -f

# create-directories:
# 	@echo "Creating directories for Docker volumes..."
# 	@mkdir -p $(DB_PATH)
# 	@mkdir -p $(WORDPRESS_PATH)