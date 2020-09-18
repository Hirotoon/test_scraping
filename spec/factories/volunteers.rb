FactoryBot.define do
	factory :volunteer do
		title { Faker::Lorem.characters(number:40) }
		group_name { Faker::Name.name }
		event_url { Faker::Lorem.characters(number:20) }
		group_id { Faker::Number.number(2) }
		group
	end
end