class Moshicom

	# APIを利用して求人募集情報を30件ずつ取得する
	def self.acquire_volunteers_data(word,count)
		keyword = URI.encode_www_form({keyword: word})
		uri = URI.parse("https://api.moshicom.com/api/events.json?entry_status=1&#{keyword}&start=#{count}&order=started_at_asc&limit=30")
        response = Net::HTTP.get_response(uri)
     	return JSON.parse(response.body) 
	end

	# 求人募集情報の合計を取得する
	def self.count_total_volunteers(volunteers_data)
		total_count = volunteers_data["Result"]["count"]
		total_count = total_count.to_i
		return total_count
	end

	 # 求人募集情報を入力し、ハッシュとして返す
	def self.input_volunteer_info(volunteers_data, count)
		title = volunteers_data["Result"]["items"][count-1]["title"] 
	  	venue = volunteers_data["Result"]["items"][count-1]["address"]
	  	date = volunteers_data["Result"]["items"][count-1]["started_at"] 
	  	date = date[0..9]
	  	date = date.gsub("-",".")
	  	open_time = ""
	  	description = volunteers_data["Result"]["items"][count-1]["summary"] 
	  	image_id = volunteers_data["Result"]["items"][count-1]["image_path"]
	  	event_url = volunteers_data["Result"]["items"][count-1]["event_url"]
	  	agent = Mechanize.new
	  	detail_volunteer_page = agent.get(event_url)
	  	group_name = detail_volunteer_page.at('//*[@id="main"]/div[3]/div[1]/div[2]/div/dl/dd/div[2]/h2/a')
	  	group_name = Sanitize.clean(group_name)
	  	hash_volunteer_info = {:タイトル名 => title, :開催場所 => venue, :開催日 => date, :開催時間 => open_time, :説明 => description, :イメージ画像 => image_id, :詳細URL => event_url, :主催者名 => group_name}
	  	return hash_volunteer_info
	end
	
	# 30件の求人募集情報をクローリングし、まだクローリングしていない求人募集情報が存在するかを確認する
	def self.over_count?(count,total)
		if (count % 30 == 0) && (total > count)
			return true
		end
	end

	# 求人募集情報を全てクローリングしたかを確認する
	def self.all_volunteers_crawled?(count,total)
		if count == total
            return true
        end
	end

end