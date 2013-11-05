Pandatanet::Application.routes.draw do
  resources :asociations

  resources :personas

  resources :licitations

  resources :corporations

  root :to => "home#index"
  match '/about' => 'home#about', via: :get
  match '/stats' => 'home#stats', via: :get
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :users
end
