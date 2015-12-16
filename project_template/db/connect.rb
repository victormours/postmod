  sleek_config_path = File.expand_path('sleek.yml', __dir__)
  sleek_config = YAML.load_file(sleek_config_path)

ActiveRecord::Base.establish_connection(Sleek::Config.database)

