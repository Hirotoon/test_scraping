class Volunteer < ApplicationRecord

	belongs_to :group, optional: true
	validates :title, presence: true
	validates :group_name, presence: true
	validates :event_url, presence: true
	
end
