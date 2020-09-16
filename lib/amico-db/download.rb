require 'colorize'

module AmicoDb
  class Download
    attr_accessor :user
    attr_accessor :host
    attr_accessor :remote_path
    attr_accessor :local_path
    attr_accessor :cmd

    def initialize(user: AmicoDb.configuration.ssh_user,
                   host: AmicoDb.configuration.host,
                   remote_path: AmicoDb.configuration.remote_path,
                   local_path: AmicoDb.configuration.local_path)
      self.user = user
      self.host = host
      self.remote_path = remote_path
      self.local_path = local_path
      self.cmd = generate_cmd
    end

    def call
      create_dir_if_not_exist
      puts 'Start download with scp:'.colorize(:red)
      puts cmd.colorize(:red)
      system(cmd)
    end

    private

    def create_dir_if_not_exist
      File.mkdir_p(File.dirname(local_path))
    end

    def generate_cmd

      "scp #{user}@#{host}:#{remote_path} #{local_path}"
    end

  end
end
