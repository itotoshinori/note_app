class Info < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true, uniqueness: true

  def create_info(user_id)
    Info.create(user_id:user_id)
  end
end
