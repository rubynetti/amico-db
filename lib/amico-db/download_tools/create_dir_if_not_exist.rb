module AmicoDb
  module DownloadTools
    class CreateDirIfNotExist
      attr_accessor :path
      def initialize(path)
        self.path = path
      end

      def call
        dirname = File.dirname(path)
        FileUtils.mkdir_p(dirname)
      end
    end
  end
end
