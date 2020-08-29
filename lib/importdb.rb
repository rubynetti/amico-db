require 'importdb/configuration'
require 'importdb/version'
require 'importdb/download'
require 'importdb/dump'
require 'importdb/dump_cmd'
require 'importdb/railtie' if defined?(Rails::Railtie)

module Importdb
  class Error < StandardError; end

  def self.configuration
    @configuration ||= Importdb::Configuration.new
  end

  def self.configure
    yield(configuration)
  end
end
