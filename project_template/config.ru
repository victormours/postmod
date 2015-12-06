require_relative "web/web"
require_relative "api/api"

map '/' do
  run Web.new
end
map '/api' do
  run Api
end
