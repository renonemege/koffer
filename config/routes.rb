Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: "registrations" }
  root to: 'pages#home'

  resources :cities, only: [:index, :show] do
    resources :surveys, only: [:create, :new]
    resources :reviews, only: [:create]
    resources :responses, only: [:create, :new]
  end

  resources :users, only: [:index, :show] do
    resources :reviews, only: [:create]
  end

  resources :chatrooms, only: [:show, :create, :index] do
    resources :messages, only: :create
  end

  resources :user_cities, only: [:create]
  resources :user_interests, only: [:create]
  resource :after_signup, only: [:show]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  if Rails.env.development?
    get 'kitchensink', to: 'pages#kitchensink'
  end

end
