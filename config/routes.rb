Rails.application.routes.draw do
  devise_for :users

  root to: "homes#top"
  get 'home/about', to: 'homes#about', as: 'about'

  resources :books, only: [:update, :create, :index, :show, :destroy, :edit] do
      resource :favorite, only: [:create, :destroy]
      resources :book_comments, only: [:create, :destroy]
  end
  
  resources :users, only: [:index, :show, :edit, :update]
  

 
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
