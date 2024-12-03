# frozen_string_literal: true

require 'sidekiq/web'

Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root to: 'home#index'

  get 'characters/user/:user_id', to: 'characters#from_user', as: :characters_by_user
  resources :comics
  resources :characters do
    get 'user/user_id', to: 'characters#from_user', on: :collection, as: :characters_by_user
    get 'export', to: 'characters#export', on: :collection, as: :export
  end

  mount Sidekiq::Web => '/sidekiq'

  match '*path', to: 'application#routing_error', via: :all
end
