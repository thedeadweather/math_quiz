class GamesController < ApplicationController
  before_action :authenticate_user!

  def create
    questions_amount = params[:amount]
    @game = current_user.games.build

    unless (10..100).include?(questions_amount.to_i)
      redirect_to :new_game, alert: 'неправильно'
    end

    if @game.save
      Question.order('RANDOM()').
        first(questions_amount).
        each { |q| @game.questions << q }
      redirect_to @game, alert: 'игра началалсь'
    else
      redirect_to user_path(current_user), alert "ошибка при создании игры"
    end
  end

  def show

  end

  def answer
    # выясняем, правильно ли оветили
    @answer_is_correct = @game.answer_current_question!(params[:answer])
    @game_question = @game.current_game_question

    unless @answer_is_correct
      flash[:alert] = I18n.t(
        'controllers.games.bad_answer',
        answer: @game_question.correct_answer,
        prize: view_context.number_to_currency(@game.prize)
      )
    end

    # Выбираем поведение в зависимости от формата запроса
    respond_to do |format|
      # Если это html-запрос, по-старинке редиректим пользователя в зависимости от ситуации
      format.html do
        if @answer_is_correct && !@game.finished?
          redirect_to game_path(@game)
        else
          redirect_to user_path(current_user)
        end
      end

      # Если это js-запрос, то ничего не делаем и контролл попытается отрисовать шаблон
      # <controller>/<action>.<format>.erb (в нашем случае games/answer.js.erb)
      format.js {}
    end
end
