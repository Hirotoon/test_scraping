# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

# 出力先のログファイルの指定
rails_env = ENV['RAILS_ENV'] || :development
set :output, 'log/crontab.log'
# ジョブの実行環境の指定
set :environment, rails_env
require 'active_support/core_ext/time'

def jst(time)
    Time.zone = 'Asia/Tokyo'
    Time.zone.parse(time).localtime($system_utc_offset)
end

#10分おきの場合(every 10.minutes do) 
every 1.day, at: jst('15:08') do
    begin
        rake "scrape:get_moshicom_info"
        rake "scrape:get_Blueship_info"
    rescue => e
        raise e
    end
end

every 1.day, at: jst('15:10') do
    begin
        rake "connect:group_connect_volunteers"
    rescue => e
        raise e
    end
end

