class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :set_current_user, except: [:show]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    # скоуп finished прописан в модели games
    @games = @user.games.finished
  end

  private

  def set_current_user
    @user = current_user
  end
end
