require 'test_helper'

class DownloadTest < Minitest::Test
  def test_cmd
    download = AmicoDb::Download.new
    user = AmicoDb.configuration.ssh_user
    expect = "scp #{user}@www.example.com:/var/www/yourproject/dumps/db.sql ./dumps/db.sql"
    assert_equal expect, download.cmd
  end
end
