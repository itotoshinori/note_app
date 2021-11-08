require 'rails_helper'

RSpec.describe 'Memos', type: :request do
  before do
    @user = FactoryBot.create(:user)
    @memos = Memo.create(description:"テスト投稿1", important:false, complete:true,
      twitter:false, public:true, user_id:@user.id, link:"http://yahoo.co.jp")
    @memos = Memo.create(description:"テスト投稿2", important:true, complete:false,
      twitter:true, public:false, user_id:@user.id, link:nil) 
    @memos = Memo.create(description:"投稿データ3", important:false, complete:true,
        twitter:false, public:true, user_id:@user.id, link:nil)  
  end
  describe 'GET index' do
    before do
      sign_in(@user)
      @memo_all_count = Memo.all.length 
    end
    it "ログインしていれば200httpレスポンスを返すとともにJsonデータを返す" do
      get "/api/memos/"
      expect(response.status).to eq 200
      json = JSON.parse(response.body)
      expect(json.length).to eq(@memo_all_count)
      description = json[0]["description"]
      expect(description).to eq("投稿データ3")
    end
    it "未完了のJsonデータを返す" do
      get "/api/memos/?complete=false"
      expect(response.status).to eq 200
      json = JSON.parse(response.body)
      memo_count = Memo.where(complete:false).length
      expect(json.length).to eq(memo_count)
      description = json[0]["description"]
      expect(description).to eq("テスト投稿2")
    end
    it "更新順のJsonデータを返す" do
      get "/api/memos/?updateAt=true"
      expect(response.status).to eq 200
      json = JSON.parse(response.body)
      expect(json.length).to eq(@memo_all_count)
      description = json[0]["description"]
      expect(description).to eq("投稿データ3")
    end
    it "重要順のJsonデータを返す" do
      get "/api/memos/?upImportant=true"
      expect(response.status).to eq 200
      json = JSON.parse(response.body)
      expect(json.length).to eq(@memo_all_count)
      description = json[0]["description"]
      expect(description).to eq("テスト投稿2")
    end
    it "twitterのJsonデータを返す" do
      get "/api/memos/?searchTwitter=true"
      expect(response.status).to eq 200
      json = JSON.parse(response.body)
      memo_count = Memo.where(twitter:true).length
      expect(json.length).to eq(memo_count)
      description = json[0]["description"]
      expect(description).to eq("テスト投稿2")
    end
    it "リンクありのJsonデータを返す" do
      get "/api/memos/?searchLink=true"
      expect(response.status).to eq 200
      json = JSON.parse(response.body)
      memo_count = Memo.where("link <> ?", '').length
      expect(json.length).to eq(memo_count)
      description = json[0]["description"]
      expect(description).to eq("テスト投稿1")
    end
    it "ログインしてなければ401httpレスポンスを返す" do
      sign_out(@user)
      get "/api/memos/"
      expect(response.status).to eq 401
    end
  end
  describe 'POST create' do
    it "createの挙動確認" do
      sign_in(@user)
      post '/api/memos/', params: { description: 'test', user_id: @user.id, link:"http://example.com" }, headers: { 'ACCEPT' => 'application/json' }
      expect(response.status).to eq 201
      expect(Memo.last.description).to eq("test")
    end
    it "ログインしてなければcreateは失敗する" do
      post '/api/memos/', params: { description: 'test', user_id: @user.id, link:"http://example.com" }, headers: { 'ACCEPT' => 'application/json' }
      expect(response.status).to eq 401
    end  
  end
  describe 'Patch update' do
    before do
      @memo_id = Memo.first.id
    end
    it "updateの挙動確認" do 
      sign_in(@user)
      patch "/api/memos/#{ @memo_id }", params: { description:"更新test", user_id:@user.id}, headers: { 'ACCEPT' => 'application/json' }
      expect(response.status).to eq 200
      expect(Memo.first.description).to eq("更新test")
    end
    it "ログインしてなければupdateは失敗する" do
      patch "/api/memos/#{ @memo_id }", params: { description:"更新test", user_id:@user.id}, headers: { 'ACCEPT' => 'application/json' }
      expect(response.status).to eq 401 
    end  
  end
  describe 'DELETE' do
    before do
      @memo_id = Memo.first.id
      @memo_count = Memo.count
    end
    it "deleteの挙動確認" do 
      sign_in(@user)
      delete "/api/memos/#{ @memo_id }", headers: { 'ACCEPT' => 'application/json' }
      expect(response.status).to eq 200
      expect(Memo.count).to eq(@memo_count-1)
    end
    it "ログインしてなければdeleteは失敗する" do
      delete "/api/memos/#{ @memo_id }", headers: { 'ACCEPT' => 'application/json' }
      expect(response.status).to eq 401
    end  
  end
  describe 'show' do
    before do
      @memo_id = Memo.first.id
    end
    it "showの挙動確認" do
      memo = get "/memos/#{ @memo_id }"
      expect(memo).to eq 200
    end  
  end
end