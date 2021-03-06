class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(
      :account_update,
      keys: [:password, :password_confirmation, :current_password, :name, :age]
    )
    devise_parameter_sanitizer.permit(
      :sign_up,
      keys: [:name, :age, :password, :password_confirmation, :current_password]
    )
  end

  # хелпер для проверки ответов, используемый в контроллере игры
  def check_answer!(user_a, correct_a)
    case user_a
    when correct_a
      @game.correct += 1
    else
      @game.incorrect += 1
    end
  end
end
