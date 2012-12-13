Dashboard::Application.routes.draw do
  # The priority is based upon order of creation:
  # first created -> highest priority.
  resources :dashboard
  resources :sessions, only: [:new, :create, :destroy]


  root :to => "dashboard#index"
  match "/signin", :to => "sessions#new"
  match "/signout", :to => "sessions#destroy", via: :delete
  match "/update_git", :to => "git_logs#new", via: :post
end
