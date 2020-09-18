require 'rails_helper'
require 'rake'

describe '登録済み団体とボランティアの紐付け　テスト' do
    before(:all) do
        @rake = Rake::Application.new
        Rake.application = @rake
        Rake.application.rake_require 'tasks/connect'
        Rake::Task.define_task(:environment)
    end

    before(:each) do
        @rake[task].reenable 
    end

    let(:task) { 'connect:group_connect_volunteers' }
    it '正常に動作すること' do
        expect(@rake[task].invoke).to be_truthy
    end
end