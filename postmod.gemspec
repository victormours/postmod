Gem::Specification.new do |gem|
  gem.name = 'postmod'
  gem.summary = "A facilitator for post-modern application architecture or something."
  gem.version = '0.0.7'
  gem.licenses = ['MIT']

  gem.authors = ['Victor Mours']
  gem.email = 'victor.mours@gmail.com'

  gem.executables = ['postmod']
  gem.files = Dir["lib/**/*.rb"] + Dir["project_template/**/*"]

  gem.add_runtime_dependency 'chaplin'
  gem.add_runtime_dependency 'activesupport'
  gem.add_runtime_dependency 'standalone_migrations'

  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'rspec-preloader'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'guard'
  gem.add_development_dependency 'guard-shell'
  gem.add_development_dependency 'guard-bundler'
end
