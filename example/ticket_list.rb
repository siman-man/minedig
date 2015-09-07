require 'minedig'
require 'dotenv'
require 'pp'
Dotenv.load

# Creaet redmien instance.
redmine = Minedig::Redmine.new do |config|
  config.home = ENV["REDMINE_HOME"]
  config.api_key = ENV["API_KEY"]
end

ticket = redmine.ticket(83757)

