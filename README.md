![Ruby](https://github.com/rubynetti/amico-db/workflows/Ruby/badge.svg)

# Amico Db

Import **mysql db from docker container**.

## Requirements

### Docker container
To use this tool you need a docker container on the server with your db.

### Pipeline
For visualize progress on the cli you need to install pv: https://man7.org/linux/man-pages/man1/pv.1.html.

```bash
# Install PV in your Dockerfile
RUN apt-get update && apt-get install -y pv

```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'amico-db', git: 'https://github.com/rubynetti/amico-db.git'
```

## Configuration

For example inside a rails initializer (config/initializers/amico-db.rb).

```ruby
dev = Rails.configuration.database_configuration["production"]
production = Rails.configuration.database_configuration["production"]

AmicoDb.configure do |config|
  config.ssh_user = 'root'
  config.host = 'your_host'
  config.remote_app_path = '/var/www/yourproject'
  config.folder_dump = '/dumps/db.sql'
  config.local_path = './dumps/db.sql'

  config.db_name = production['database']
  config.db_user = production['username']
  config.db_dev_dbname = dev['database']
  config.db_dev_username = dev['username']
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

Database service need MYSQL_ROOT_PASSWORD and share dumps folder.

```yaml
services:
  db:
    environment:
      - MYSQL_ROOT_PASSWORD=$DB_PASSWORD
    volumes:
      - ./dumps:/dumps
```

## Usage

```bash
rake db:dump
rake db:import_from_staging
rake db:import_from_sql (importa sql da dumps/db-staging.sql)
```

## For development of this gem with Docker

- `docker-compose up` run `rake test` command
