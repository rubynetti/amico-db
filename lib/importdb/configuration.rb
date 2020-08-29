module Importdb
  class Configuration
    attr_accessor :ssh_user
    attr_accessor :host
    attr_accessor :remote_app_path
    attr_accessor :folder_dump
    attr_accessor :local_path
    attr_accessor :db_name
    attr_accessor :db_user
    attr_accessor :db_dev_dbname
    attr_accessor :db_dev_username

    def initialize
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

    # ex: /var/www/yourproject/db.sql
    def remote_path
      "#{remote_app_path}#{folder_dump}"
    end

  end
end