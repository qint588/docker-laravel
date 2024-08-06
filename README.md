# Setup

#### 1. Clone template
```
git clone git@github.com:qint588/docker-laravel.git
```

#### 2. Clone project
```
cd source && git clone {remote url} -b {branch} .
```

#### 3. Setup env
```
cp .env.example .env
```

#### 4: Change port public when run docker
```
PHP_PORT=30001
REDIS_PORT=39002
MYSQL_PORT=39003
MYSQL_ROOT_USER=root
MYSQL_ROOT_PASSWORD=PwDev123
MYSQL_DATABASE=base
```

#### 5. Run project
```
make init && make setup
```