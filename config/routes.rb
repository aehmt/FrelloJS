Rails.application.routes.draw do
  root 'profile#home'

  # resources :boards
  resources :tasks
  
  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  resources :users do
    resources :boards
  end
end
