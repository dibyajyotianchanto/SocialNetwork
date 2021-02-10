Rails.application.routes.draw do
  resources :commentaries
  resources :comments
  devise_for :users
  resources :posts
  root 'posts#index'
end
