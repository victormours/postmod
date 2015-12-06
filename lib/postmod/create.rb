require 'fileutils'
require 'chaplin'

module Postmod::Create

  def self.call(project_path)
    project_template_path = "#{__dir__}/../../project_template"
    FileUtils.mkdir(project_path)

    FileUtils.mkdir("#{project_path}/data_store")
    FileUtils.cp_r("#{project_template_path}/data_store", project_path)

    FileUtils.cp_r("#{project_template_path}/core", project_path)
    FileUtils.cp("#{project_template_path}/Gemfile", "#{project_path}/Gemfile")
    FileUtils.cp("#{project_template_path}/Procfile", "#{project_path}/Procfile")
    FileUtils.cp("#{project_template_path}/config.ru", "#{project_path}/config.ru")

    File.write("#{project_path}/.ruby-version", '2.2.2')

    FileUtils.mkdir("#{project_path}/api")

    Chaplin::New.("#{project_path}/web")
    FileUtils.cp("#{project_template_path}/web/config.ru", "#{project_path}/web/config.ru")
    FileUtils.cp("#{project_template_path}/web/web.rb", "#{project_path}/web/web.rb")
  end

end
