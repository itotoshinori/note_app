require 'rails_helper'

RSpec.describe MemoMailer, type: :model do
  before do
    @mail =
      MemoMailer.creation_email(
        'test@email.com',
        'テスト送信がありました',
        'がんばれ',
        '〇〇さ
      んから',
      ).deliver_now
  end
  describe 'メール送信テスト' do
    it '送信されたか確認' do
      expect(ActionMailer::Base.deliveries.size).to eq 1
    end
    it '件名等確認' do
      expect(@mail.From.unparsed_value).to eq 'tito40358@gmail.com'
      expect(@mail.To.unparsed_value).to eq 'test@email.com'
      expect(@mail.subject).to eq 'メモアプリからのお知らせ'
    end
  end
  after { ActionMailer::Base.deliveries.clear }
end
