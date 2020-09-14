class GamesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_game, only: %i[show answer destroy]

  def new
    @new_game = current_user.games.build
  end

  def create
    Game.where(finished_at: nil).destroy_all
    @game = current_user.games.build(game_params)

    if @game.save
      redirect_to user_game_path(@game.user, @game), notice: 'игра началалсь'
    else
      redirect_to user_path(current_user), alert: 'ошибка при создании игры'
    end
  end

  def show
    @question = @game.create_question
    @total = @game.correct.to_i + @game.incorrect.to_i
  end

  def answer
    total = @game.correct.to_i + @game.incorrect.to_i
    user_answer = params[:answer]
    correct_answer = params[:correct]

    if @game.attempt.to_i - total == 1
      check_answer!(user_answer, correct_answer)
      @game.finished_at = Time.now
      @game.save!
      redirect_to user_game_path(@game.user, @game), notice: 'игра окончена'
    else
      check_answer!(user_answer, correct_answer)
      @game.save!
      redirect_to user_game_path(@game.user, @game), notice: 'следующий вопрос'
    end
  end

  def destroy
    @game.destroy
    redirect_to user_path(current_user), notice: 'игра удалена!'
  end

  private

  def set_game
    @game ||= Game.find params[:id]
  end

  def game_params
    params.require(:game).permit(:attempt, :finished_at, :correct, :incorrect)
  end
end
