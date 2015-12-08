require 'spec_helper'

RSpec.describe Postmod::Generate::Model do

  it "creates the right ruby file" do
    described_class.(model_path)

    expect(file_content).to eq expected_file_content
  end

  it "creates a new database migration" do
    described_class.(model_path)
    expect(`ls db/migrate`).to end_with "some_model.rb\n"
  end

  describe "for a model in a module" do
    before { Postmod::Generate::Module.("lib/some_module") }

    it "creates a file with the right class name" do
      described_class.("lib/some_module/some_model")
      class_line = File.readlines("lib/some_module/some_model.rb").first
      expect(class_line).to start_with "class SomeModule::SomeModel"
    end
  end

  let(:expected_file_content) do
    <<ACTION_FILE
class SomeModel < ActiveRecord::Base

end
ACTION_FILE
  end

  let(:model_path) { "lib/some_model" }
  let(:file_content) { File.readlines(model_path + ".rb").reduce(&:+) }

  before do
    initial_path
    Postmod::Create.(project_path)
    FileUtils.cd(project_path)
  end
  let(:initial_path) { FileUtils.pwd }

  after do
    FileUtils.cd(initial_path)
    `rm -rf #{project_path}`
  end
  let(:project_path) { 'spec/tmp/toto' }
end


