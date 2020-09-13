class Question < ApplicationRecord
  has_many :games, through: :game_questions

  validates :correct, inclusion: { in: [true, false] }, allow_nil: false
end
