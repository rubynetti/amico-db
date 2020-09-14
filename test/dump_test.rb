require 'test_helper'
class DumpTest  < Minitest::Test
  def test_dump
    mock = Minitest::Mock.new
    def mock.open_channel(&block); end
    def mock.loop; end

    # Thanks to this article:
    # https://mixandgo.com/learn/how-to-test-a-function-that-yields-a-block-with-minitest-and-rspec
    Net::SSH.stub(:start, {}, mock) do
      AmicoDb::Dump.new.call
    end
  end
end
