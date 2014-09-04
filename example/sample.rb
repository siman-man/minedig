require 'redmine'
require 'pp'
Dotenv.load

project = Redmine::Project.new do |config|
  config.redmine_host = ENV["REDMINE_HOST"]
  config.path = ENV["PROJECT_PATH"]
  config.api_key = ENV["API_KEY"]
end

puts project.redmine_host

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
