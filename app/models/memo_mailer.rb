class MemoMailer < ApplicationMailer
  def creation_email(address,category,content,user)
    @address = address
    @category = category
    @content = content
    @user_name = user
    #send = mail(subject: "メモアプリからのお知らせ",to: "tito40358@outlook.jp")
    if mail(subject: "メモアプリからのお知らせ",to: @address)
      cotent_return = "送信成功"
    else
      cotent_return = "送信失敗"
    end
  end
end
