require 'minedig'
require 'dotenv'
require 'pp'
Dotenv.load

# Creaet redmien instance.
redmine = Minedig::Redmine.new do |config|
  config.home = ENV["REDMINE_HOME"]
  config.api_key = ENV["API_KEY"]
end

tickets = redmine.tickets(count: :all)
puts tickets.size
puts tickets.last.id
tickets.each do |ticket|
  #puts ticket.id
end