require 'test_helper'

class ConfigurationTest < Minitest::Test
  def test_simple_configuration
    AmicoDb.configure do |config|
      config.ssh_user = 'another_user'
    end

    assert 'another_user', AmicoDb.configuration.ssh_user
  end
end