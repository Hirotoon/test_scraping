require 'rails_helper'

RSpec.describe "Groupモデルのテスト", type: :model do

	describe 'バリデーションのテスト'do 
		let(:group) { build(:group) }
		subject {test_group.valid? }

		context "nameカラム" do
		    let(:test_group) { group }
		    let(:other_group) { create(:group) }
		    it "空欄でないこと" do
		    	test_group.name = ''
		    	is_expected.to eq false;
		    end

		    it "一意性であること" do
		    	test_group.name = other_group.name
		    	is_expected.to eq false;
		    end
		    it '2文字以上であること' do
		        test_group.name = Faker::Lorem.characters(number:1)
		        is_expected.to eq false;
		    end
		    it '100文字以下であること' do
		        test_group.name = Faker::Lorem.characters(number:101)
		        is_expected.to eq false;
		    end

		end
		context "addressカラム" do
			let(:test_group) { group }
			it "空欄でないこと" do
				test_group.address = ''
		    	expect(test_group).not_to be_valid
		    end
		end	
		context "active_areaカラム" do
			let(:test_group) { group }
			it "空欄でないこと" do
				test_group.active_area = ''
		    	is_expected.to eq false;
		    end
		end
		context "descriptionカラム" do
			let(:test_group) { group }
			it "空欄でないこと" do
				test_group.description = ''
		    	is_expected.to eq false;
		    end
		end	
	end

	describe 'アソシエーションのテスト' do
	    context 'Volunteerモデルとの関係' do
	      it '1:Nとなっている' do
	        expect(Group.reflect_on_association(:volunteers).macro).to eq :has_many
	      end
	    end
	end					
end