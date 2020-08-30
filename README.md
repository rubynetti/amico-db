![Ruby](https://github.com/rubynetti/amico-db/workflows/Ruby/badge.svg)

# Amico Db

Import **mysql db from docker container**.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'amico-db', git: 'git@github.com:rubynetti/amico-db.git'
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

