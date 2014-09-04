require 'redmine'
require 'pp'
Dotenv.load

project = Redmine::Project.new do |config|
  config.redmine_host = ENV["REDMINE_HOST"]
  config.path = ENV["PROJECT_PATH"]
  config.api_key = ENV["API_KEY"]
end

puts project.user_name
puts project.redmine_host

member_list = project.member_list

member_list.each do |member|
  puts member.name
end
