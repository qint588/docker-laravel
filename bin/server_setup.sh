#!/bin/sh
set -e

APP_NAME=$(grep DOCKER_APP_NAME .env | cut -d '=' -f2)-app

echo "Deploying application ..."

# Enter maintenance mode
(docker exec ${APP_NAME} php artisan down) || true
    # Install composer
    docker exec ${APP_NAME} composer install

    # Generate key
    docker exec ${APP_NAME} php artisan key:generate --force

    # Storage link
    docker exec ${APP_NAME} php artisan storage:link --force

    # Migration
    docker exec ${APP_NAME} php artisan migrate --force

    # Seed
    docker exec ${APP_NAME} php artisan db:seed --force

    # Chmod folder
    docker exec ${APP_NAME} chmod -R 777 storage
    docker exec ${APP_NAME} chmod -R 777 bootstrap/cache
    docker exec ${APP_NAME} chmod -R 777 public

# Exit maintenance mode
docker exec ${APP_NAME} php artisan up

echo "Application deployed!"