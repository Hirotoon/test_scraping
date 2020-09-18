require 'rails_helper'

describe 'ボランティアのテスト' do
 	let!(:volunteer) { create(:volunteer) }
 	let!(:other_volunteer) { create(:volunteer, group_id: nil) }
  	before do
	      visit volunteers_path
	end
	    context '一覧画面のテスト' do
	      it '登録されている団体と紐づいたボランティアが表示される' do
	        expect(page).to have_link '詳細へ', href: volunteer_path(volunteer)
	      end

	      it '登録されている団体と紐づいていないボランティアは表示されない' do
	        expect(page).to_not have_link '詳細へ', href: volunteer_path(other_volunteer)
	      end
	end
end  
