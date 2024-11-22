Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'home#index'

  get 'characters/new', to: 'characters#new', as: :create_character
  post 'characters', to: 'characters#create'
  get 'characters/:id', to: 'characters#show'
  get 'characters/:id/edit', to: 'characters#edit', as: :edit_character
  patch 'characters/:id', to: 'characters#update'
  delete 'characters/:id', to: 'characters#destroy', as: :character
  get 'characters', to: 'characters#index'
  get 'characters/user/:id', to: 'characters#from_user'
end
