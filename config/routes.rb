Rails.application.routes.draw do
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Devise routes for users
  devise_for :users

  # Routes for users
  resources :users, only: [:show, :update]  

  # Defines the root path route ("/")
  root 'posts#index'

  # Routes for posts
  resources :posts do 
    # Routes for likes
    resources :likes, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
  end

  # Routes for comments
  resources :comments, only: [:create, :destroy]

  # Routes for friendships
  resources :friendships, only: [:create, :update, :index] do
    member do
      patch :approve
      delete :decline
    end
  end

  # Routes for notifications
  resources :notifications, only: [:index] do
    member do
      post :dismiss
    end
  end
end
