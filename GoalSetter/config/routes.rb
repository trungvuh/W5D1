Rails.application.routes.draw do

  resources :goals
  resources :users, only: [:new, :create]
  resources :comments
  resource :session, only: [:new, :create, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
