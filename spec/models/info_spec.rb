require 'rails_helper'

RSpec.describe Info, type: :model do
  before do
    @user = FactoryBot.create(:user)
  end
  describe '登録時の挙動確認' do
    it 'ユーザーが登録されていれば登録　OK' do
      @info = Info.new.create_info(@user.id)
      expect(@info.valid?).to eq(true)
    end
    it 'ユーザーが登録なければ　NG' do
      @info = Info.new.create_info(2)
      expect(@info.valid?).to eq(false)
    end
    it '重複登録　NG' do
      @info = Info.new.create_info(@user.id)
      @info2 = Info.new.create_info(@user.id)
      expect(@info2.valid?).to eq(false)
    end
    it 'user_idブランク　NG' do
      @info = Info.new.create_info('')
      expect(@info.valid?).to eq(false)
    end
  end
end