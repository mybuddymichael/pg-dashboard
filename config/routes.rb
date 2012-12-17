Dashboard::Application.routes.draw do
  # The priority is based upon order of creation:
  # first created -> highest priority.
  resources :dashboard
  resources :sessions, only: [:new, :create, :destroy]


  root :to => "sessions#new"
  match "/signin", :to => "sessions#new"
  match "/signout", :to => "sessions#destroy", via: :delete
  match "/update_git", :to => "git_logs#update_git", via: :post
  match "/git_logs", :to => "git_logs#list"
end
