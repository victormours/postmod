require 'chaplin'

class Web
  def initialize
    @app = Chaplin.new(__dir__).server
  end

  def call(env)
    @app.call(env)
  end
end
