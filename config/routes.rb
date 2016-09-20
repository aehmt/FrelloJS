Rails.application.routes.draw do
  resources :boards
  root 'profile#home'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :tasks
end
