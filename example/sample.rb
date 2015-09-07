require 'minedig'
require 'dotenv'
Dotenv.load

# Creaet redmien instance.
redmine = Minedig::Redmine.new do |config|
  config.home = ENV["REDMINE_HOME"]
  config.api_key = ENV["API_KEY"]
end

# show redmien host.
puts redmine.host

fetch_count = 25
offset = 0

# rad2infoプロジェクトの取得
project = redmine.project('rad2info')

loop do
  tickets = project.tickets(count: fetch_count, offset: offset)
  puts "offset = #{offset} - #{offset + fetch_count}, ticket count = #{tickets.size}"

  # 更新するチケットが無くなったら終了
  break if tickets.empty?

  tickets.each do |ticket|
    text = ticket[:description]

    if text =~ /old_pass/
      begin
        text.gsub!('old_pass', 'new_pass')
        ticket.description = text
        ticket.update
        sleep(1)
        puts "ticket id = #{ticket[:id]} success"
      rescue Exception => ex
        puts ex.message
        exit(1)
      end
    end
  end

  offset += fetch_count
end
