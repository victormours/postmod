module Postmod::Generate
  Dir["#{__FILE__.gsub(".rb", '')}/*.rb"].each {|file| require file }
end
