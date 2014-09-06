require 'spec_helper'

describe 'URL parser' do
  describe 'parse chekc' do
    it 'normal' do
      uri = 'http://example.com'

      redmine = Minedig::Redmine.new do |config|
        config.home = uri
      end

      expect(redmine.host).to eq('example.com')
    end

    it 'subpath' do
      uri = 'http://example.com/redmine'

      redmine = Minedig::Redmine.new do |config|
        config.home = uri
      end

      expect(redmine.host).to eq('example.com')
      expect(redmine.root_path).to eq('/redmine')
    end
  end
end
