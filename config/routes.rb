Rails.application.routes.draw do
  # get 'homes/index'
  
  resources :buses

  authenticate :user, lambda { |u| u.admin? } do
    mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  end
  # mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  devise_for :users do
    resources :buses do
      post 'reservations/create/:user_id', to: 'reservations#create'
    end
  end

  resources :reservations

  get '/:id/reservations', to: 'reservations#user_reservations', as: 'user_reservations'
  delete '/:id/reservations/:reservation_id', to: 'reservations#cancel_reservation', as: 'destroy_reservation'

  get '/logout', to: 'sessions#destroy', as: :logout
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "homes#index"
end
