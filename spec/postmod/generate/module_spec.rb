require 'spec_helper'

RSpec.describe Postmod::Generate::Module do

  it "creates a ruby file with the proper module name" do
    described_class.('SomeModule')
  end
end
