class Memo < ApplicationRecord
  validates :description, presence: true
  #本文１字から１３０字まで
  validates :description,
    length: { minimum: 1, maximum: 130 }
  validates :important, presence: false
  validates :complete, presence: false
  validates :twitter, presence: false
  validates :important, presence: false
  validates :user_id, presence: true
end
