require 'minedig'
require 'pp'
Dotenv.load

# Creaet redmien instance.
redmine = Minedig::Redmine.new do |config|
  config.host = ENV["REDMINE_HOST"]
  config.api_key = ENV["API_KEY"]
end

# show redmien host.
puts redmine.host

project = redmine.project('api')
p redmine.ticket(1000)
user_list = project.user_list
tickets = project.tickets
ticket = tickets.first

p ticket.id
p ticket.properties
p ticket.id
puts ticket.priority
puts ticket.project
puts ticket.status

user_list.each do |user|
  puts user.name
end
