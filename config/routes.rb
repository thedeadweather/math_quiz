Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'users#index'

  # для удобства ресурсы делаем вложенными
  # тк игры без юзера не может быть
  resources :users, only: %i[index show] do
    resources :games, only: %i[create show new destroy] do
      put 'answer', on: :member
    end
  end
end
