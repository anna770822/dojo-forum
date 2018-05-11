Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  

  resources :posts do
    resources :comments
  end

  root "posts#index"
  
  resources :categories, only: [:show]

  resources :users, only: [:show] do
    member do 
      get :comments
      get :drafts
      get :friends
    end
  end

  resources :friendships, only: :create do
    member do 
      post :accept
      delete :ignore
    end
  end

  resources :feeds, only: [:index]
  
  namespace :admin do 
    resources :users, only: [:index, :update]
    resources :categories
  end
end
