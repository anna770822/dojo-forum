Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :posts
  
  resources :posts, only: [:show] do
    resources :comments, only: [:index, :create]
  end

  root "posts#index"
  


  namespace :admin do 
    resources :users, only: [:index, :update]
    resources :categories
  end
end
