require 'rails_helper'

RSpec.describe 'Infos', type: :request do
  before do
    @user = FactoryBot.create(:user)    
    @info = Info.create(user_id:@user.id)
  end
  describe 'GET index' do
    before do
      sign_in(@user)
    end
    it "ログインしていれば200httpレスポンスを返すとともにJsonデータを返す" do
      get "/api/infos/1"
      json = JSON.parse(response.body)
      expect(json["user_id"]).to eq(@user.id)
      expect(response.status).to eq 200
    end
    it "ログインしていればログイン画面へ" do
      sign_out(@user)
      get "/api/infos/1"
      expect(response.status).to eq 302
    end
  end
  describe 'put Update' do
    it "ログイン時のupdateの挙動確認" do 
      sign_in(@user)
      put "/api/infos/#{ @info.id }", params: { twitter_tag:"更新test"}, headers: { 'ACCEPT' => 'application/json' }
      expect(response.status).to eq 200
      expect(Info.first.twitter_tag).to eq("更新test")
    end
    it "ログアウト時のupdateの挙動確認" do
      sign_out(@user)
      put "/api/infos/#{ @info.id }", params: { twitter_tag:"更新test"}, headers: { 'ACCEPT' => 'application/json' }
      expect(response.status).to eq 302
    end
  end
end