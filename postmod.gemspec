Gem::Specification.new do |gem|
  gem.name = 'postmod'
  gem.version = '0.0.0'
  gem.files = Dir["lib/**/*.rb"] + Dir["default_project/**/*"]

  gem.add_runtime_dependency 'chaplin'
  gem.add_runtime_dependency 'activesupport'

  gem.add_development_dependency 'rspec'
end
