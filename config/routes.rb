Rails.application.routes.draw do
  match 'auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
  match 'auth/failure', to: redirect('/'), via: [:get, :post]
  match 'signout', to: 'sessions#destroy', as: 'signout', via: [:get, :post]

  resources :items, only: [:index, :show, :create, :update]

  resources :orders, only: [:index, :create, :update]

  root 'foods#index'
end
