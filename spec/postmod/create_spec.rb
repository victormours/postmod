require 'spec_helper'

RSpec.describe Postmod::Create do

  it "creates a new Postmod project" do
    described_class.('spec/tmp/toto')
  end

  it "creates a console in the bin directory" do
    described_class.('spec/tmp/toto')
    expect(console_file_content).to eq expected_console_file_content
  end

  it "creates a .env file with the database url" do
    described_class.('spec/tmp/toto')
    expect(dotenv_file_content).to eq "export DATABASE_URL=postgres:///toto_dev"
  end

  let(:dotenv_file_content) { File.readlines('spec/tmp/toto/.env').reduce(&:+) }

  let(:expected_console_file_content) do
  <<CONSOLE_FILE
#!/usr/bin/env ruby
require 'pry'
require_relative '../lib/toto'
ActiveRecord::Base.establish_connection
Toto.pry
CONSOLE_FILE
  end

  let(:console_file_content) { File.readlines('spec/tmp/toto/bin/console').reduce(&:+) }

  after { `rm -rf spec/tmp/toto` }

end


