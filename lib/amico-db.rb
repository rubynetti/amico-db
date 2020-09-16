require 'amico-db/configuration'
require 'amico-db/version'
require 'amico-db/download'
require 'amico-db/download_tools/create_dir_if_not_exist'
require 'amico-db/dump'
require 'amico-db/dump_cmd'
require 'amico-db/railtie' if defined?(Rails::Railtie)

module AmicoDb
  def self.configuration
    @configuration ||= AmicoDb::Configuration.new
  end

  def self.configure
    yield(configuration)
  end
end
