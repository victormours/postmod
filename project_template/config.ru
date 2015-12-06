require_relative "web/web"

map '/' do
  run Web.new
end
