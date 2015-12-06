Gem::Specification.new do |gem|
  gem.name = 'postmod'
  gem.version = '0.0.0'
  gem.authors = ['Victor Mours']
  gem.summary = "A facilitator for post-modern application architecture or something."

  gem.files = Dir["lib/**/*.rb"] + Dir["bin/*"] + Dir["default_project/**/*"]
  gem.executables = ['postmod']

  gem.add_runtime_dependency 'chaplin'
  gem.add_runtime_dependency 'activesupport'

  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'guard'
  gem.add_development_dependency 'guard-shell'
  gem.add_development_dependency 'guard-bundler'
  gem.add_development_dependency 'guard-shell'
end
