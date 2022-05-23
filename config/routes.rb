Rails.application.routes.draw do
  devise_for :users
  root to: "homes#top"
  get "homes/about" => "homes#about", as: 'about'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
   resources :books, only: [:new, :index, :show, :edit, :create, :update, :destroy]

   resources :users,only: [:show, :edit, :index, :update]
end
