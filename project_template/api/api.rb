require 'sinatra/base'
require 'json'

ActiveRecord::Base.establish_connection

class Api < Sinatra::Application
end
