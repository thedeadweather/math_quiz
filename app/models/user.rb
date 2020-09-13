class User < ApplicationRecord
  has_many :games, dependent: :destroy

  validates :name, presence: true, length: { maximum: 15, minimun: 5 }
  validates :age, presence: true, numericality: { less_than_or_equal_to: 150,  only_integer: true }
  validates :email, presence: true, uniqueness: true
end
