module ApplicationHelper
  def average_time(game)
    total = game.finished_at.to_time - game.created_at.to_time
    "#{(total / game.attempt).round(2)} сек."
  end

  def total_time(game)
    total = game.finished_at.to_time - game.created_at.to_time
    "#{total.round(2)} сек."
  end
end
