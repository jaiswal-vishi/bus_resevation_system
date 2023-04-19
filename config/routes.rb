Rails.application.routes.draw do
  get 'homes/index'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  get '/logout', to: 'sessions#destroy', as: :logout
  root "homes#index"
end
