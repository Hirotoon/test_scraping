require "date"
require './lib/scrape'
namespace :scrape do 

    desc "get Blueship information"
	task :get_Blueship_info => :environment do
		Scrape.Blueship_get
	end	

    desc "get moshicom information"
    task :get_moshicom_info => :environment do
		Scrape.moshicom_get
    end
end