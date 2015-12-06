require 'active_support/core_ext/string/inflections'

module Postmod::Generate
  Action = Postmod::Action.new(:action_path) do

    def call
      File.open(action_filename, 'w') do |file|
        file.puts action_content
      end
    end

    private

    def action_content
      <<ACTION_FILE
class #{action_name}

  def self.call
  end

end
ACTION_FILE
    end

    def action_name
      action_path.gsub(/^.*core\/lib\//, '').camelize
    end

    def action_filename
      action_path + '.rb'
    end


  end
end
