class Group < ApplicationRecord
	
	has_many :volunteers
	attachment :image
	validates :name, uniqueness: true, presence: true, length: { in: 2..100 }
	validates :address, presence: true
	validates :active_area, presence: true
	validates :description, presence: true

	# 求人募集情報との紐付けを行う
	def connect_volunteers(group_name, group_id)
		volunteers = Volunteer.where(group_name: group_name)
    	volunteers.each do |volunteer|
    		volunteer.group_id = group_id
    		volunteer.save
    	end
	end

	# 求人募集情報との紐付け解除を行う
	def disconnect_volunteers(group_volunteers)
		volunteers = group_volunteers
		volunteers.each do |volunteer|
			volunteer.group_id = nil
			volunteer.save
		end
	end

end
