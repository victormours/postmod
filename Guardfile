guard :shell do
  watch(/(lib\/*)|(spec\/.*_spec.rb)/) { system('bundle exec rspec') }
end

guard :bundler do
  require 'guard/bundler'

  files = ['Gemfile'] + Dir['*.gemspec']
end
