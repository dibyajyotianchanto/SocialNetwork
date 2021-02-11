Rails.application.routes.draw do
  resources :commentaries
  resources :likes
  devise_for :users
  resources :posts
  root 'posts#index'
  get '/unlike', to: 'likes#unlike', as: :unlikepost
  get '/users/:id(.:format)', to: 'users#show', as: :user
end
