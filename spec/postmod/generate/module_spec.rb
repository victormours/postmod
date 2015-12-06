require 'spec_helper'

RSpec.describe Postmod::Generate::Module do

  it "creates a directory" do
    described_class.(module_path)
    expect(Dir.exists?(module_path)).to be_truthy
  end

  it "creates a ruby file with the proper module name" do
    described_class.(module_path)
    file_content = File.readlines(module_path + ".rb").reduce(&:+)

    expect(file_content).to eq expected_file_content
  end

  let(:expected_file_content) do
    <<MODULE_FILE
module SomeModule
  Dir["\#{__FILE__.gsub(".rb", '')}/*.rb"].each { |file| require file }
end
MODULE_FILE
  end

  let(:module_path) { "#{project_path}/core/lib/some_module" }

  before { Postmod::Create.(project_path) }
  after { `rm -rf #{project_path}` }
  let(:project_path) { 'spec/tmp/toto' }
end
