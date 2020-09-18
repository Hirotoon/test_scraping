require './lib/moshicom'
require './lib/blueship'
require "date"
class Scrape

    # e-moshicomサイトをスクレイピングし、未保存求人募集情報を保存する
  	def self.moshicom_get
        count_volunteers = 1
        word = "ボランティア募集"
        volunteers_data = Moshicom.acquire_volunteers_data(word, count_volunteers)
        total_volunteers = Moshicom.count_total_volunteers(volunteers_data)
        while true do
            hash_volunteer_info = Moshicom.input_volunteer_info(volunteers_data, count_volunteers)
            save_volunteer_info(hash_volunteer_info)
            if Moshicom.over_count?(count_volunteers, total_volunteers)
              volunteers_data = Moshicom.acquire_volunteers_data(word, count_volunteers+1)
            end
            if Moshicom.all_volunteers_crawled?(count_volunteers, total_volunteers)
                break;
            end
            count_volunteers += 1
        end
        time = Time.current
        puts "moshicomサイトの情報をスクレイピングしました。終了時間："+ time.strftime("%Y年%-m月%-d日 %H時%M分%S秒")
  	end

    # Blueshipサイトをスクレイピングし、未保存求人情報を保存する
  	def self.Blueship_get
      	@next_url = ""
        while true do
            volunteers_page = Blueship.retrieve_volunteers_page(@next_url)
            volunteers_data = Blueship.acquire_volunteers_data(volunteers_page)
            @next_url , @next_link = Blueship.load_next_link(volunteers_page)
            Blueship.save_volunteers_per_page(volunteers_data,volunteers_page)
            if Blueship.next_link_empty?(@next_link)
                break
            end
        end
        time = Time.current
        puts "BlueShipサイトの情報をスクレイピングしました。終了時間："+ time.strftime("%Y年%-m月%-d日 %H時%M分%S秒")
  	end

    # 未保存求人募集情報を保存する
    def self.save_volunteer_info(hash_volunteer_info)
        if Volunteer.where(group_name: hash_volunteer_info[:主催者名], title: hash_volunteer_info[:タイトル名], date: hash_volunteer_info[:開催日], open_time: hash_volunteer_info[:開催時間]).empty?
            volunteer =Volunteer.new
            volunteer.title = hash_volunteer_info[:タイトル名]
            volunteer.venue = hash_volunteer_info[:開催場所]
            volunteer.date = hash_volunteer_info[:開催日]
            volunteer.open_time = hash_volunteer_info[:開催時間]
            volunteer.description = hash_volunteer_info[:説明]
            volunteer.image_id = hash_volunteer_info[:イメージ画像]
            volunteer.event_url = hash_volunteer_info[:詳細URL]
            volunteer.group_name = hash_volunteer_info[:主催者名]
            volunteer.save
        end 
    end
end