module AmicoDb
  class Dump
    attr_accessor :host
    attr_accessor :ssh_user
    attr_accessor :remote_path

    def initialize(host: AmicoDb.configuration.host,
                   ssh_user: AmicoDb.configuration.ssh_user)
      self.host = host
      self.ssh_user = ssh_user
    end

    def call
      Net::SSH.start(host, ssh_user) do |ssh|
        ssh.open_channel { |channel| execute_stuff(channel) }
        ssh.loop
      end
    end

    private

    def execute_stuff(channel)
      log_start
      channel.request_pty
      commands = DumpCmd.new.call
      channel.exec(commands) do |ch|
        puts commands.colorize(:cyan)
        ch.on_data do |_c, data|
          puts "Il server dice: #{data.inspect}".colorize(:blue)
        end
      end
      channel.on_close { log_end }
    end

    def log_start
      puts '------------------------------------'.colorize(:red)
      puts '--- RUBYNETTI DUMP POWER -----------'.colorize(:red)
      puts '------------------------------------'.colorize(:red)
      puts 'Connesso al server'.colorize(:blue)
      puts '------------------------------------'.colorize(:red)
    end

    def log_end
      puts '--------------------------------------'.colorize(:red)
      puts 'Ciao Rubynetti, io chiudo connessione.'.colorize(:green)
      puts '--------------------------------------'.colorize(:red)
    end
  end
end
