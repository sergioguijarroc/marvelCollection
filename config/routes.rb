Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get "bienvenida", to: "home#index"
  get "characters/new", to: "characters#new"
  post "characters", to:"characters#create"
  get "characters/:id", to:"characters#show"
end