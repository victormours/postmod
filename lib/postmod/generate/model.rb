require 'active_support/core_ext/string/inflections'
require "rails/generators"

module Postmod::Generate
  Model = Postmod::Action.new(:model_path, :options) do

    def call
      create_ruby_file
      create_migration
    end

    private

    def create_ruby_file
      File.open(model_filename, 'w') do |file|
        file.puts model_content
      end
    end

    def create_migration
      Rails::Generators.invoke(
        "active_record:migration",
        ["create_#{model_name}"] + migration_options,
        destination_root: Pathname.new(".")
      )
    end

    def migration_options
      [options, "created_at:timestamps", "updated_at:timestamps"].flatten
    end

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
