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

tickets = project.tickets

user_list.each do |user|
  puts user.name
end

tickets.each do |ticket|
  text = ticket[:description]
  puts "ticket id = #{ticket[:id]}"
  puts "prject id = #{ticket[:project_id]}, name = #{ticket[:project]}"
  puts "tracker id = #{ticket.tracker_id}, name = #{ticket.tracker}"

  text.gsub!("テストチケット", "サンプルチケット")
  ticket.description = text

  ticket.update
end

