require 'redmine_tool'
Dotenv.load

project = RedmineTool::Project.new do |config|
  config.redmine_host = ENV["REDMINE_HOST"]
  config.path = ENV["REDMINE_PATH"]
  config.api_key = ENV["API_KEY"]
end

puts project.user_name
puts project.redmine_host

puts project.full_path
puts project.member_list