require 'grape'

ActiveRecord::Base.establish_connection

class Api < Grape::API
  format :json
end
