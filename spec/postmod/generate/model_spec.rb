require 'spec_helper'

RSpec.describe Postmod::Generate::Model do

  describe "migration file" do
    it "creates a new database migration" do
      described_class.(model_path)
      expect(`ls db/migrate`).to end_with "create_article.rb\n"
    end

    it "creates a new database migration" do
      described_class.(model_path, "content:string")
      expect(migration_file_content).to include "t.string :content"
    end

    it "add timestamps to the migration" do
      described_class.(model_path, "content:string")
      expect(migration_file_content).to include "t.timestamps :created_at"
      expect(migration_file_content).to include "t.timestamps :updated_at"
    end

    let(:migration_file_name) { `ls db/migrate`.chomp }
    let(:migration_file_content) do
      File.readlines("db/migrate/#{migration_file_name}").reduce(&:+)
    end
  end

  it "creates the right ruby file" do
    described_class.(model_path)
    expect(file_content).to eq expected_file_content
  end

  describe "for a model in a module" do
    before { Postmod::Generate::Module.("lib/some_module") }

    it "creates a file with the right class name" do
      described_class.("lib/some_module/article")
      class_line = File.readlines("lib/some_module/article.rb").first
      expect(class_line).to start_with "class SomeModule::Article"
    end
  end

  let(:expected_file_content) do
    <<ACTION_FILE
class Article < ActiveRecord::Base

end
ACTION_FILE
  end

  let(:model_path) { "lib/article" }
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


