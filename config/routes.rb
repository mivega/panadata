Pandatanet::Application.routes.draw do
  resources :licitations

  resources :corporations

  root :to => "home#index"
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :users
end