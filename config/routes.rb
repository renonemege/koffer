Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :cities, only: [] do
    resources :surveys , only: [:create, :new]
  end
end
