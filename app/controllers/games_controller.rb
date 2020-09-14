class GamesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_game, only: %i[show answer]

  def new
    @new_game = current_user.games.build
  end

  def create
    @game = current_user.games.build(game_params)

    if @game.save
      redirect_to user_game_path(@game.user, @game), notice: 'игра началалсь'
    else
      redirect_to user_path(current_user), alert: 'ошибка при создании игры'
    end
  end

  def show
    @question = @game.create_question
  end

  def answer
    total = @game.correct.to_i + @game.incorrect.to_i

    if @game.attempt.to_i == total
      @game.finished_at = Time.now
      @game.save!
      redirect_to user_game_path(@game.user, @game), notice: 'игра окончена'
    else
      user_answer = params[:answer]
      correct_answer = params[:correct]
      case user_answer
      when correct_answer
        @game.correct += 1
      else
        @game.incorrect += 1
      end

      @game.save!
      redirect_to user_game_path(@game.user, @game), notice: 'следующий вопрос'
    end
  end

  private

  def set_game
    @game ||= Game.find params[:id]
  end

  def game_params
    params.require(:game).permit(:attempt, :finished_at, :correct, :incorrect)
  end
end
