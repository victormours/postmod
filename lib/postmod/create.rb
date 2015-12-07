require 'fileutils'
require 'chaplin'

module Postmod
  Create = Action.new(:project_path) do

    def call
      create_project
      create_data_store
      create_core
      create_api
      create_web
    end

    private

    def create_project
      FileUtils.mkdir(project_path)
      FileUtils.cp("#{project_template_path}/Gemfile", "#{project_path}/Gemfile")
      FileUtils.cp("#{project_template_path}/Procfile", "#{project_path}/Procfile")
      FileUtils.cp("#{project_template_path}/config.ru", "#{project_path}/config.ru")
      File.write("#{project_path}/.ruby-version", '2.2.2')
    end

    def create_data_store
      FileUtils.cp_r("#{project_template_path}/data_store", project_path)
    end

    def create_core
      FileUtils.cp_r("#{project_template_path}/core", project_path)
      Postmod::Generate::Module.("#{project_path}/core/lib/#{project_name}")
    end

    def create_api
      FileUtils.cp_r("#{project_template_path}/api", project_path)

      api_file_content = File.readlines("#{project_template_path}/api/api.rb")

      File.open("#{project_path}/api/api.rb", 'w') do |api_file|
        api_file.puts "require_relative '../core/lib/#{project_name}'"
        api_file_content.each { |line| api_file.puts line }
      end
    end

    def create_web
      Chaplin::New.("#{project_path}/web")
      FileUtils.cp("#{project_template_path}/web/config.ru", "#{project_path}/web/config.ru")
      FileUtils.cp("#{project_template_path}/web/web.rb", "#{project_path}/web/web.rb")
      FileUtils.cp("#{project_template_path}/web/app.yml", "#{project_path}/web/app.yml")
    end

    def project_template_path
      "#{__dir__}/../../project_template"
    end

    def project_name
      project_path.split("/").last
    end

  end
end
