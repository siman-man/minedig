require 'minedig'
require 'pp'
Dotenv.load

redmine = Redmine.new do |config|
  config.host = ENV["REDMINE_HOST"]
  config.api_key = ENV["API_KEY"]
end

puts redmine.host

project = redmine.project('イノベーション推進部')

user_list = project.user_list
ticket = project.ticket(63484)

p ticket.id
p ticket.properties
p ticket.id
puts ticket.priority
puts ticket.project
puts ticket.status

user_list.each do |user|
  puts user.name
end
