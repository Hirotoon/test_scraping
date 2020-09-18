require './lib/connect'
namespace :connect do
	 desc "group connect with volunteers"
	 task :group_connect_volunteers => :environment do 
        Connect.group_and_volunteers
	 end
end