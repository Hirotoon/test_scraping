class Connect

    # 団体と求人の紐付けを行う
	def self.group_and_volunteers
		volunteers = Volunteer.all
        volunteers.each do |volunteer|
            group = Group.find_by(name: volunteer.group_name)
            if group.present?
                volunteer.group_id = group.id
                volunteer.save
            end
        end
        puts "登録されている団体と対応するボランティアの紐付けを実行しました。"
	end
    
end