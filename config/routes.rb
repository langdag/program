Rails.application.routes.draw do
  resources :users
  resources :partnerships
  resources :sessions, only: [:create, :destroy]
  get 'partnership_programs', to: 'partnerships#get_partnerships'
  resources :subscriptions, only: :create
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
