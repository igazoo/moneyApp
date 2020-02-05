Rails.application.routes.draw do
  get 'expenses/new'
  get 'sessions/new'
  get 'users/new'
  get 'tops/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'tops#index'

  resources :users
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :expenses
end
