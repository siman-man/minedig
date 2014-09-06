require 'spec_helper'

describe 'Project' do
  describe 'project configure' do
    before(:all) do
      @projects_json = load_fixture('projects.json')
    end

    it 'check config' do
      redmine = Minedig::Redmine.new do |config|
        redmine.home = 'example.com/redmine'
      end
    end
  end
end
