![Ruby](https://github.com/rubynetti/amico-db/workflows/Ruby/badge.svg)

# Amico Db

Import **mysql db from docker container**.

## Requirements

### Docker container
To use this tool you need a docker container on the server with your db.

### Pipeline
For visualize progress on the cli you need to install pv: https://man7.org/linux/man-pages/man1/pv.1.html.

```bash
FROM ruby:2.6.5

RUN apt-get update -qq && \
    apt-get install -y build-essential libpq-dev && \
    curl -sL https://deb.nodesource.com/setup_10.x -o nodesource_setup.sh && \
    bash ./nodesource_setup.sh && \
    rm ./nodesource_setup.sh && \
    apt-get install nodejs


# Installa yarn
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install yarn && apt-get -y install cron && apt-get -y install vim

**RUN apt-get update && apt-get install -y pv**

WORKDIR /app

ARG rails_uid=1000
RUN useradd -u $rails_uid -Um rails && \
    chown -R rails:rails /app

USER rails

```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'amico-db', git: 'https://github.com/rubynetti/amico-db.git'
```

## Configuration

For example inside a rails initializer (config/initializers/amico-db.rb).

```ruby
AmicoDb.configure do |config|
  config.ssh_user = "user"
  config.host = "www.example.com"
  config.remote_app_path = "/var/www/yourproject"
  config.folder_dump = "/db.sql"
  config.local_path = './dumps/db.sql'
  config.db_name = 'dbname'
  config.db_user = 'dbusername'
  config.db_dev_dbname = 'dbname'
  config.db_dev_username = 'dbdevname'
end
```

## Docker Dev Configuration (docker-compose.development.yml)

Your dev configuration need to copy ssh folder inside.
Example:

```yaml
services:
  web:
    build: .
    command: ['rails', 'server', '-b', '0']
    volumes:
      - .:/app
      - ~/.ssh:/home/rails/.ssh
```

## Docker Production Configuration (docker-compose.production.yml)

Database service need MYSQL_ROOT_PASSWORD

```yaml
services:
  db:
    environment:
      - MYSQL_ROOT_PASSWORD=$DB_PASSWORD
```

## Usage

```bash
rake db:dump
rake db:import_from_staging
rake db:import_from_sql (importa sql da dumps/db-staging.sql)
```

## For development of this gem with Docker

- `docker-compose up` run `rake test` command
