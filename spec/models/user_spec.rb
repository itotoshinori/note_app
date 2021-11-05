require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = User.new(name:"test",email:"test@user.jp", password:"password")
    #@user = build(:user)
    #@user = create(:user)
  end

  describe 'バリデーション' do
    it 'nameとemailとpasswordどちらも値が設定されていれば、OK' do
      expect(@user.valid?).to eq(true)
    end
    it 'nameがブランクだったらNG' do
      @user.name = ''
      expect(@user.valid?).to eq(false)
    end
    it 'emailがブランクだったらNG' do
      @user.email = ''
      expect(@user.valid?).to eq(false)
    end
    it 'emailがemail形式でなければNG' do
      @user.email = 'test@test'
      expect(@user.valid?).to eq(false)
    end
    it 'emailが重複したらNG' do
      @user.save
      @user2 = User.new(name:"test",email:"test@user.jp", password:"password")
      expect(@user2.valid?).to eq(false)
    end
  end
end
