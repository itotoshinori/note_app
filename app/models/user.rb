class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  #validates :name
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable
  validates :name, presence: true
  VALID_EMAIL_REGEX = /\A\S+@\S+\.\S+\z/
  validates :email, format: { with: VALID_EMAIL_REGEX }, uniqueness: true
  validates :password, length: { minimum: 7, maximum: 30 }
  has_many :memos, dependent: :destroy

  def password_reset(id)
    target_user = User.find(id)
    target_user.password = "password"
    if target_user.save
      result = true
    else
      result = false
    end
  end
end
