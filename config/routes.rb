Pandatanet::Application.routes.draw do
  resources :owner_brands

  resources :owners

  resources :asociations, only: [:index,:show]

  resources :personas, only: [:index,:show]

  resources :licitations, only: [:index,:show]

  resources :corporations, only: [:index,:show]
  resources :brands, only: [:index,:show]
  resources :owners, only: [:index,:show]

  root :to => "home#about"
  match '/about' => 'home#about', via: :get
  match '/about' => 'home#about', via: :get
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :users
  get "/sitemap" => redirect("https://s3.amazonaws.com/panadata/sitemaps/sitemap.xml.gz")
end
