require 'rails_helper'

RSpec.describe "Volunteerモデルのテスト", type: :model do

	describe 'バリデーションのテスト'do 
		let(:group) { create(:group) }
    	let!(:volunteer) { build(:volunteer, group_id: group.id) }

		context "titleカラム" do
		    it "空欄でないこと" do
		    	volunteer.title = ''
		    	expect(volunteer.valid?).to eq false;
		    end
		end
		context "group_nameカラム" do
			it "空欄でないこと" do
				volunteer.group_name = ''
				expect(volunteer.valid?).to eq false;
		    end
		end	
		context "event_urlカラム" do
			it "空欄でないこと" do
				volunteer.event_url = ''
				expect(volunteer.valid?).to eq false;
		    end
		end
	end

	describe 'アソシエーションのテスト' do
	    context 'Groupモデルとの関係' do
	      it 'N:1となっている' do
	          expect(Volunteer.reflect_on_association(:group).macro).to eq :belongs_to
	      end
	    end
	end			
end