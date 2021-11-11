require 'rails_helper'

RSpec.describe Reset, type: :model do
  before { @user = FactoryBot.create(:user) }

  describe 'password_resetの設定確認' do
    it 'パスワード変更を確認' do
      user_reset = Reset.new(@user.email)
      expect(user_reset.new_password == @user.id).to eq(false)
    end
    it '登録されてないアドレスだとnewpasswordをfalseで返す' do
      user_reset = Reset.new('test1234@email.com')
      expect(user_reset.new_password).to eq(false)
    end
  end
end
