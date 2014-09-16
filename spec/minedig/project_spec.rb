require 'spec_helper'

describe 'Project' do
  describe 'project configure' do
    before(:all) do
      @projects_json = load_fixture('projects.json')
    end

    it 'check config' do
      redmine = Minedig::Redmine.new do |config|
        config.home = 'example.com/redmine'
      end

      allow(redmine).to receive(:projects).and_return(@projects_json)
    end
  end
end
