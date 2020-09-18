require 'rails_helper'
require 'rake'

describe 'スクレイピングが実行できているかのテスト' do
    before(:all) do
        @rake = Rake::Application.new
        Rake.application = @rake
        Rake.application.rake_require 'tasks/scrape'
        Rake::Task.define_task(:environment)
    end

    before(:each) do
        @rake[task].reenable
        @rake[task].reenable
    end

    describe 'moshicomサイトのスクレイピング テスト' do
        let(:task) { 'scrape:get_moshicom_info' }
        it '正常に動作すること' do
          expect(@rake[task].invoke).to be_truthy
        end
    end
    describe 'Blueshipサイトのスクレイピング テスト' do
        let(:task) { 'scrape:get_Blueship_info' }
        it '正常に動作すること' do
          expect(@rake[task].invoke).to be_truthy
        end
    end
end