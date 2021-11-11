class Reset
  def initialize(email)
    user = User.find_by(email:email)
    if user.present?
      @new_password = (0...8).map{ ('A'..'Z').to_a[rand(26)] }.join
      user.update(password:@new_password)
    else
      @new_password = false
    end
  end
  def new_password
    @new_password
  end
end