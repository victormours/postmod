require 'spec_helper'

RSpec.describe Postmod::Create do

  it "creates a new Postmod project" do
    described_class.('spec/tmp/toto')
  end

  after { `rm -rf spec/tmp/toto` }

end


