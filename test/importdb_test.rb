require "test_helper"

class ImportdbTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Importdb::VERSION
  end
end
