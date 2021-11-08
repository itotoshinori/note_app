class Memo < ApplicationRecord
  #本文１字から１３０字まで
  belongs_to :user
  validates :description,
    length: { minimum: 1, maximum: 130 }
  validates :important, inclusion: [true, false]
  validates :complete, inclusion: [true, false]
  validates :twitter, inclusion: [true, false]
  validates :public, inclusion: [true, false]
  validates :user_id, numericality: {only_integer: true}
  with_options if: :link? do
    validates :link, format: /\A#{URI::regexp(%w(http https))}\z/
  end
end
