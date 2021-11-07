require 'rails_helper'

RSpec.describe Memo, type: :model do
  before do
    @memo = Memo.new(description:"テスト投稿", important:false, complete:false,
      twitter:false, public:false, user_id:1, link:nil)
  end
  describe 'バリデーション' do
    it 'defaultの設定では　OK' do
      expect(@memo.valid?).to eq(true)
    end
    it '本文がブランクだとエラー' do
      @memo.description = ''
      expect(@memo.valid?).to eq(false)
    end
    it '本文が131文字以上だとエラー' do
      content = ''
      (1..131).each do |num|
        content = content + 'あ'
      end
      @memo.description = content
      expect(@memo.valid?).to eq(false)
    end
    it '重要がブランクだとエラー' do
      @memo.important = ''
      expect(@memo.valid?).to eq(false)
    end
    it '完成がブランクだとエラー' do
      @memo.complete = ''
      expect(@memo.valid?).to eq(false)
    end
    it 'Twitterがブランクだとエラー' do
      @memo.twitter = ''
      expect(@memo.valid?).to eq(false)
    end
    it '公開がブランクだとエラー' do
      @memo.public = ''
      expect(@memo.valid?).to eq(false)
    end
    it 'ユーザーidがブランクだったらエラー' do
      @memo.user_id = ''
      expect(@memo.valid?).to eq(false)
    end
    it 'ユーザーidに数字以外が入れば NG' do
      @memo.user_id = 'あああ'
      expect(@memo.valid?).to eq(false)
    end
    it 'linkがurlじゃなかったエラー' do
      @memo.link = 'aaaa'
      expect(@memo.valid?).to eq(false)
    end
    it 'linkがurlだったらOK' do
      @memo.link = 'https://yahoo.co.jp'
      expect(@memo.valid?).to eq(true)
    end
  end
end
