require 'rails_helper'

RSpec.describe 'Memos', type: :request do
  before do
    @user = User.create(name:"伊藤",email:"samples@email.com",password:"password")
    @user.save
  end
  describe 'GET index' do
    before do
      @memos = FactoryBot.create_list(:memo, 10)
      #@memo = FactoryBot.create(:memo)
      @user = User.new(name:"test",email:"test@user.jp", password:"password")
      sign_in(@user)
    end
    it "ログインしていれば200httpレスポンスを返す" do
      @user.id = 1
      get "/api/memos/"
      expect(response.status).to eq 200
      json = JSON.parse(response.body)
      expect(json.length).to eq(@memos.length)
    end
    it "ログインしてなければ401httpレスポンスを返す" do
      sign_out(@user)
      get "/api/memos/"
      expect(response.status).to eq 401
    end
  end
end