Rails.application.routes.draw do
  resources :commentaries
  resources :likes
  devise_for :users
  resources :posts
  resources :friendships
  root 'posts#index'
  get '/unlike', to: 'likes#unlike', as: :unlikepost
  get '/users/:id(.:format)', to: 'users#show', as: :user
  get '/friendaccept', to: 'friendships#acceptfriendship', as: :accept_friend_request
  get '/friendreject', to: 'friendships#rejectfriendship', as: :reject_friend_request
  get '/friendsend', to: 'friendships#sendfriendship', as: :send_friend_request
  get '/friendunsend', to: 'friendships#unsendfriendship', as: :unsend_friend_request
  get '/friendunfriend', to: 'friendships#unfriendfriendship', as: :unfriend_friend_request
end
