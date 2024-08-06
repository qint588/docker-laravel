# cp .env.dev .env

docker compose exec base_php composer install

docker compose exec base_php php artisan key:generate

docker compose exec base_php php artisan storage:link

docker compose exec base_php php artisan migrate

docker compose exec base_php php artisan db:seed