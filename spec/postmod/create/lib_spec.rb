require 'spec_helper'

RSpec.describe Postmod::Create::Lib do

  it "creates a new module" do
    described_class.(module_path)
    expect(file_content).to eq expected_file_content
  end

  let(:file_content) { File.readlines(module_path + ".rb").reduce(&:+) }

  let(:expected_file_content) do
    <<MODULE_FILE
module SomeModule
  Dir["\#{__FILE__.gsub(/\.rb$/, '')}/*.rb"].each {|file| require file }
end
MODULE_FILE
  end

  let(:module_path) { "#{project_path}/lib/some_module" }

  before { Dir.mkdir(project_path) }
  after { `rm -rf #{project_path}` }
  let(:project_path) { 'spec/tmp/toto' }

end


