Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  

  resources :posts do
    resources :comments
    post :collect
    post :uncollect
  end

  root "posts#index"
  
  resources :categories, only: [:show]

  resources :users, only: [:show, :edit] do
    member do 
      get :comments
      get :collects
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

  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      
      post "/login" => "auth#login"
      post "/logout" => "auth#logout"

      resources :posts, only: [:index, :create, :show, :update, :destroy]
    end
  end
end
