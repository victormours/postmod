require 'active_support/inflector/inflections'

module Postmod::Generate
  Module = Postmod::Action.new(:module_path) do

    def call
      Dir.mkdir(module_path)

      File.open(module_filename, 'w') do |file|
        file.puts module_content
      end
    end

    private

    def module_content
      <<MODULE_FILE
module #{module_name}
  Dir["\#{__FILE__.gsub(".rb", '')}/*.rb"].each { |file| require file }
end
MODULE_FILE
    end

    def module_name
      module_path.split('/').last.camelize
    end

    def module_filename
      module_path + '.rb'
    end

  end
end
