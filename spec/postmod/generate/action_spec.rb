require 'spec_helper'

RSpec.describe Postmod::Generate::Action do

  it "creates a ruby file with the right name" do
    described_class.(action_path)

    expect(file_content).to eq expected_file_content
  end

  describe "for an action in a module" do
    before { Postmod::Generate::Module.("#{project_path}/core/lib/some_module") }

    it "creates a file with the right class name" do
      described_class.("#{project_path}/core/lib/some_module/some_action")
      first_line = File.readlines("#{project_path}/core/lib/some_module/some_action.rb").first
      expect(first_line).to start_with "SomeModule::SomeAction"
    end
  end

  let(:expected_file_content) do
    <<ACTION_FILE
SomeAction = Postmod::Action.new() do

  def call
  end

end
ACTION_FILE
  end

  let(:action_path) { "#{project_path}/core/lib/some_action" }
  let(:file_content) { File.readlines(action_path + ".rb").reduce(&:+) }

  before { Postmod::Create.(project_path) }
  after { `rm -rf #{project_path}` }
  let(:project_path) { 'spec/tmp/toto' }
end


