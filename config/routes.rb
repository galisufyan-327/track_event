# == Route Map
#
# Prefix Verb   URI Pattern           Controller#Action
#  users GET    /users(.:format)      users#index
#        POST   /users(.:format)      users#create
#   user GET    /users/:id(.:format)  users#show
#        PATCH  /users/:id(.:format)  users#update
#        PUT    /users/:id(.:format)  users#update
#        DELETE /users/:id(.:format)  users#destroy
# events GET    /events(.:format)     events#index
#        POST   /events(.:format)     events#create
#  event GET    /events/:id(.:format) events#show
#        PATCH  /events/:id(.:format) events#update
#        PUT    /events/:id(.:format) events#update
#        DELETE /events/:id(.:format) events#destroy
#

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :company_users do
  end
  resources :events do
  end
  resources :upcoming_user_rewards, only: [:index]
  resources :user_rewards_history, only: [:index]
  resources :badges, only: [:index]
end
