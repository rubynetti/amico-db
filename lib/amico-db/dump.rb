require 'colorize'
require 'net/ssh'
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
      log_before
      Net::SSH.start(host, ssh_user) do |ssh|
        log_start
        ssh.open_channel do |channel|
          execute_stuff(channel)
        end
        ssh.loop
      end
    end

    private

    def execute_stuff(channel)
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

    def log_before
      puts '------------------------------------'.colorize(:red)
      puts "#{ssh_user}@#{host}".colorize(:red)
      puts '------------------------------------'.colorize(:red)
    end

    def log_start
      puts '------------------------------------'.colorize(:red)
      puts '--- RUBYNETTI DUMP POWER -----------'.colorize(:red)
      puts '------------------------------------'.colorize(:red)
      puts 'Connected to server'.colorize(:blue)
      puts '------------------------------------'.colorize(:red)
    end

    def log_end
      puts '--------------------------------------'.colorize(:red)
      puts 'Hi Rubynetti, close connection.'.colorize(:green)
      puts '--------------------------------------'.colorize(:red)
    end
  end
end
