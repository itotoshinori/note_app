require 'rails_helper'

RSpec.describe "Users", type: :request do
    before do
        @user = FactoryBot.create(:user)
        @user2 = User.create(name:"test2",email:"test2@email.com",password:"password")  
    end
    describe 'GET index' do
        before do
          sign_in(@user)
        end
        it "管理者（１番目のユーザー）でログインしていれば200httpレスポンスを返す" do
            get "/users/"
            expect(response.status).to eq 200
        end
        it "管理者以外（１番目のユーザー以外で）でログインしていれば302httpレスポンスを返す" do
            sign_in(@user2)
            get "/users/"
            expect(response.status).to eq 302
            expect(response).to redirect_to('/')
        end
        it "ログインなしではログイン画面に遷移、302httpレスポンスを返す" do
            sign_out(@user)
            get "/users/"
            expect(response.status).to eq 302
            expect(response).to redirect_to('/users/sign_in')
        end
    end
end
