class MemoMailer < ApplicationMailer
  def creation_email(memo)
    @memo = memo
    mail(
      subject: "メモアプリからの投稿お知らせメール",
      to: "tito40358@gmail.com"
    )
  end
end
