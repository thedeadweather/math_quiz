require 'question'

class Game < ApplicationRecord
  belongs_to :user

  validates :correct, presence: true, numericality: { greater_than_or_equal_to: 0, only_integer: true }
  validates :incorrect, presence: true, numericality: { greater_than_or_equal_to: 0, only_integer: true }
  validates :attempt, presence: true, numericality: { less_than_or_equal_to: 100, greater_than_or_equal_to: 10, only_integer: true }

  scope :finished, -> { where "finished_at IS NOT NULL" }

  # игра будет генерить вопросы из lib/question.rb
  def create_question
    Question.generate_question
  end
end
