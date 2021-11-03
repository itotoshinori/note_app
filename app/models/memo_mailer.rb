class MemoMailer < ApplicationMailer
  def creation_email(category,content,user)
    @category = category
    @content = content
    @user_name = user
    mail(
      subject: "メモアプリからのお知らせ",
      to: "tito40358@outlook.jp"
    )
  end
end
