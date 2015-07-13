require 'minedig'
require 'dotenv'
require 'pp'
Dotenv.load

# Creaet redmien instance.
redmine = Minedig::Redmine.new do |config|
  config.home = ENV["REDMINE_HOME"]
  config.api_key = ENV["API_KEY"]
end

# show redmien host.
puts redmine.host

project = redmine.project('api')
user_list = project.user_list
tickets = project.tickets(count: 25)

tickets.each do |ticket|
  text = ticket[:description]
  puts "ticket id = #{ticket[:id]}"
end

