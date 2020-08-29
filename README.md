# Importdb

Import mysql db from docker container.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'amico-db', git: 'git://github.com/rubynetti/amico-db.git'
```

## Configuration

For example inside a rails initializer (config/initializers/amico-db.rb).

```ruby
Importdb.configure do |config|
  self.ssh_user = "user"
  self.host = "www.example.com"
  self.remote_app_path = "/var/www/yourproject"
  self.folder_dump = "/db.sql"
  self.local_path = './dumps/db.sql'
  self.db_name = 'dbname'
  self.db_user = 'dbusername'
  self.db_dev_dbname = 'dbname'
  self.db_dev_username = 'dbdevname'
end
```

## Usage

- rake db:import_from_staging
- rake db:import_from_sql (importa sql da dumps/db-staging.sql)

