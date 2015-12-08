require 'active_support/core_ext/string/inflections'
require "rails/generators"

module Postmod::Generate
  Model = Postmod::Action.new(:model_path) do

    def call
      File.open(model_filename, 'w') do |file|
        file.puts model_content
      end
      Rails::Generators.invoke "active_record:migration", [model_name], :destination_root => Pathname.new(".")
    end

    private

    def model_content
      <<ACTION_FILE
class #{model_name} < ActiveRecord::Base

end
ACTION_FILE
    end

    def model_name
      model_path.gsub(/^.*lib\//, '').camelize
    end

    def model_filename
      model_path + '.rb'
    end

  end
end
