require "test_helper"

class AmicoDbTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::AmicoDb::VERSION
  end
end
