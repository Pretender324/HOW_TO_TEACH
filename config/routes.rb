Rails.application.routes.draw do
  
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "posts#top"

  get "posts/index" => "posts#index"
  get "posts/new" => "posts#new"
  post "posts/create" => "posts#create"
  get "posts/:id/edit" => "posts#edit"
  post "posts/:id/update" => "posts#update"
  delete "posts/:id/destroy" => "posts#destroy", as: 'destroy'
  get "posts/:id/show" => "posts#show"
  get "posts/search" => "posts#search"
  get "posts/search_multiple" => "posts#search_multiple"

  get "mypages/:id" => "mypages#index"

  resources :posts, only: [:index, :show, :create] do
    resources :likes, only: [:create, :destroy]
  end
  
  resources :users, :only => [:show]

  devise_scope :user do
    get 'profile_edit', to: 'users/registrations#profile_edit', as: 'profile_edit'
    post 'profile_update', to: 'users/registrations#profile_update', as: 'profile_update'
  end

end
