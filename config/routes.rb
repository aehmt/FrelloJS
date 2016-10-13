Rails.application.routes.draw do
  root 'profile#home'
  
  # resources :boards
  resources :lists, only: [:create, :update]
  resources :cards, only: [:create, :update]
  resources :collaborations, only: [:create, :update]
  
  devise_for :users, controllers: {
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  post 'boards/create', to: 'boards#create'
  get 'boards/index', to: 'boards#index'
  resources :users do
    resources :boards
  end
end
