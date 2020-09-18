FactoryBot.define do
	factory :group do
		name { Faker::Name.name }
		address { Faker::Address.name }
		active_area { Faker::Lorem.characters(number:20) }
		description { Faker::Lorem.characters(number:20) }
	end
end