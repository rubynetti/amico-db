require 'test_helper'

module DownloadTools
  class CreateDirIfNotExistTest < Minitest::Test

    def test_execution
      @directory = "test/fixtures/files"
      remove_stuff_from_prev_test
      result = AmicoDb::DownloadTools::CreateDirIfNotExist.new("#{@directory}/file.sql").call
      assert File.directory?(@directory)
    end

    private

    def remove_stuff_from_prev_test
      if File.directory?(@directory)
        FileUtils.remove_dir(@directory)
      end
    end
  end
end
