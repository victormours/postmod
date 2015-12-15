require 'fileutils'
require 'chaplin'

module Postmod
  Create = Action.new(:project_path) do

    def call
      create_project
      create_lib
      create_db
      create_bin
      create_api
      create_web
      create_spec
    end

    private

    def create_project
      FileUtils.mkdir(project_path)
      FileUtils.cp_r(Dir.glob(project_template_path + "/*"), project_path)
      FileUtils.cp_r(Dir.glob(project_template_path + "/*"), project_path)
      File.write("#{project_path}/.ruby-version", '2.2.2')
      File.write("#{project_path}/.ruby-version", '2.2.2')
    end

    def create_lib
      Postmod::Generate::Module.("#{project_path}/lib/#{project_name}")
    end

    def create_db
      db_config_file = Mustache.new
      db_config_file.template_file = "#{project_path}/db/config.yml"
      db_config_file_content = db_config_file.render(app_name: project_name)

      File.write("#{project_path}/db/config.yml", db_config_file_content)
    end

    def create_bin

      File.open("#{project_path}/bin/console", 'w') do |console_file|
        console_file.puts '#!/usr/bin/env ruby'
        console_file.puts "#{project_name.capitalize}.pry"
      end
      `chmod u+x #{project_path}/bin/console`
    end

    def create_api
      api_file_content = File.readlines("#{project_template_path}/api/api.rb")

      File.open("#{project_path}/api/api.rb", 'w') do |api_file|
        api_file.puts "require_relative '../lib/#{project_name}'"
        api_file_content.each { |line| api_file.puts line }
      end
    end

    def create_web
      FileUtils.rm_rf("#{project_path}/web")
      Chaplin::New.("#{project_path}/web")
      FileUtils.cp("#{project_template_path}/web/config.ru", "#{project_path}/web/config.ru")
      FileUtils.cp("#{project_template_path}/web/web.rb", "#{project_path}/web/web.rb")
      FileUtils.cp("#{project_template_path}/web/app.yml", "#{project_path}/web/app.yml")
    end

    def create_spec
      FileUtils.cp_r("#{project_template_path}/spec", project_path)
    end

    def project_template_path
      "#{__dir__}/../../project_template"
    end

    def project_name
      project_path.split("/").last
    end

  end
end
