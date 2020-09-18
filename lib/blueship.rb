class Blueship

    # 求人募集ページを取得する
    def self.retrieve_volunteers_page(next_url)
        agent = Mechanize.new
        page = agent.get("https://blueshipjapan.com/search/event/catalog?area=0&text_date=&date=1&text_keyword=&cancelled=0&cancelled=1&order=desc"+ next_url)
        return page
    end

    # 求人募集ページから求人募集情報を取得する
    def self.acquire_volunteers_data(volunteers_page)
        volunteers_data = volunteers_page.search('//*[@id="search_result"]/div/div/ul/li/article/div[1]/h2/a')
        return volunteers_data
    end

    # 新たな求人募集ページが存在するかを確認する
    def self.load_next_link(page)
        next_links = page.search('//*[@id="search_result"]/div/div/div/a')
        next_links.each do |link|
            if link.get_attribute(:rel) == "next"
                @next_url = link.get_attribute(:href)
                @next_link = link.inner_text
                break
            else
                @next_link = ""
            end
        end
        return @next_url, @next_link
    end

    # 求人募集情報を入力し、ハッシュとして返す
    def self.input_volunteer_info(volunteer_data,num,page1)
        agent = Mechanize.new
        page = agent.get(volunteer_data.get_attribute(:href))
        title_tag = page.search('//*[@id="main_content"]/h1')
        venue_tag = page.search('//*[@id="main_content"]/div[2]/div[1]/div[2]/p[2]') 
        date_tag = page.search('//*[@id="main_content"]/div[2]/div[1]/div[1]/div[1]/p[2]')
        open_time_tag = page.search('//*[@id="main_content"]/div[2]/div[1]/div[1]/div[2]/p[2]')
        description_tag = page.search('//*[@id="main_content"]/div[2]/div[1]/div[3]/div/p')
        image_id_tag = page1.at("//*[@id=\"search_result\"]/div/div/ul/li[#{num}]/article/a/img")
        event_url_tag = page1.at("//*[@id=\"search_result\"]/div/div/ul/li[#{num}]/article/div[1]/h2/a")
        group_name_tag = page.at('div.right table tr:nth-last-child(1) td a span')
        title = Sanitize.clean(title_tag)
        venue = Sanitize.clean(venue_tag)
        date = Sanitize.clean(date_tag)
        open_time = Sanitize.clean(open_time_tag)
        description = Sanitize.clean(description_tag)
        image_id = image_id_tag.get_attribute(:src)
        event_url = event_url_tag.get_attribute(:href)
        group_name = Sanitize.clean(group_name_tag)
        hash_volunteer_info = {:タイトル名 => title, :開催場所 => venue, :開催日 => date, :開催時間 => open_time, :説明 => description, :イメージ画像 => image_id, :詳細URL => event_url, :主催者名 => group_name}
        return hash_volunteer_info
    end

    # 求人募集情報をページ毎にDBへ保存する
  	def self.save_volunteers_per_page(volunteers_data,volunteers_page)
        num = 1
    	volunteers_data.each do |volunteer_data|
            hash_volunteer_info = input_volunteer_info(volunteer_data,num,volunteers_page)
            Scrape.save_volunteer_info(hash_volunteer_info)
            num += 1
        end
  	end

    # 次の求人募集ページが存在するかどうかを確認する
  	def self.next_link_empty?(next_link)
        if next_link.empty?
    		return true
    	end
  	end

end