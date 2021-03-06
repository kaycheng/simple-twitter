Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  root "tweets#index"
  resources :tweets, only: [:index, :create] do
    member do
      post :like
      post :unlike
    end

    resources :replies, only: [:index, :create]
  end
  
  resources :followships, only: [:create, :destroy]

  resources :users, only: [:edit, :update] do
    member do
      get :tweets
      get :followings
      get :followers
      get :likes
    end
  end

  namespace :admin do
    root "tweets#index"
    resources :tweets, only: [:index, :show, :destroy]
    resources :users, only: [:index]
  end

end
