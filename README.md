![Ruby](https://github.com/rubynetti/amico-db/workflows/Ruby/badge.svg)

# Amico Db

Import **mysql db from docker container**.

## Requirements

### Docker container
To use this tool you need a docker container on the server with your db.

### Pipeline
For visualize progress on the cli you need to install pv: https://man7.org/linux/man-pages/man1/pv.1.html.

```bash
apt-get install -y pv
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

## Usage

- rake db:import_from_staging
- rake db:import_from_sql (importa sql da dumps/db-staging.sql)


## For development of this gem with Docker

- `docker-compose up` run `rake test` command
