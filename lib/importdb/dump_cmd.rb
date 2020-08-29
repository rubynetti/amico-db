module Importdb
  class DumpCmd
    attr_accessor :db_user
    attr_accessor :db_name
    attr_accessor :folder_dump
    attr_accessor :remote_app_path

    def initialize(db_user: Importdb.configuration.db_user,
                   db_name: Importdb.configuration.db_name,
                   folder_dump: Importdb.configuration.folder_dump,
                   remote_app_path: Importdb.configuration.remote_app_path)
      self.db_user = db_user
      self.db_name = db_name
      self.folder_dump = folder_dump
      self.remote_app_path = remote_app_path
    end

    def call
      cmd = "'mysqldump -u #{db_user} --ignore-table=#{db_name}.ar_internal_metadata --no-create-db -p$MYSQL_ROOT_PASSWORD #{db_name} > #{folder_dump}'"
      cmds = ["cd #{remote_app_path}", "docker-compose exec -T db bash -c #{cmd}"]
      cmds.join('; ')
    end
  end
end
