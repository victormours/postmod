module Postmod
  class Action < Struct

    def self.call(*args)
      new(*args).call
    end

  end
end
