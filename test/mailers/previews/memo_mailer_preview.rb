# Preview all emails at http://localhost:3000/rails/mailers/memo_mailer
class MemoMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/memo_mailer/creation_email
  def creation_email
    MemoMailer.creation_email
  end

end
