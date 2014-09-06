require 'minedig'

$LOAD_PATH << File.expand_path('../../lib', __FILE__)

module Helpers
  def load_fixture(filename)
    path = File.expand_path('../fixtures/' + filename, __FILE__)

    case File.extname(filename)
    when '.json'
      JSON.load(File.open(path, &:read))
    when '.xml'
    end
  end
end

RSpec.configure do |conf|
  conf.include(Helpers)
end
