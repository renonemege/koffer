Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :cities, only: [:index, :show] do
    resources :surveys , only: [:create, :new]
    resources :reviews, only: [:create]
  end

  resources :users, only: [:index, :show]
  resources :chatrooms, only: [:show, :create] do
    resources :messages, only: :create
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  if Rails.env.development?
    get 'kitchensink', to: 'pages#kitchensink'
  end

end
