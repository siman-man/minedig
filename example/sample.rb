require 'redmine_tool'
Dotenv.load

project = RedmineTool::Project.new do |config|
  config.redmine_host = ENV["REDMINE_HOST"]
  config.path = ENV["REDMINE_PATH"]
  config.api_key = ENV["API_KEY"]
end

puts project.user_name
puts project.redmine_host

project.member_list.each do |member|
  puts member.name
end

project.issue_list do |issue|
  p issue
end