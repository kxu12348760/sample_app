SampleApp::Application.routes.draw do
  resources :users
  resources :sessions, only: [:new, :create, :destroy]
  
  root :to => "static_pages#home"

  match "/signup" => "users#new"
  match "/signin" => "sessions#new"
  match "/signout" => "sessions#destroy", via: :delete
  match "/about" => "static_pages#about"
  match "/help" => "static_pages#help"
  match "/contact" => "static_pages#contact"
end
