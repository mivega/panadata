Pandatanet::Application.routes.draw do

  devise_for :users

  resources :importaciones, only: [:index,:show]
  resources :exportaciones, only: [:index,:show]
  resources :users, only: [:show]
  resources :entidades, only: [:index,:show]
  resources :contraloria, only: [:index,:show]
  resources :proveedores , only: [:index,:show]
  resources :owner_brands, only: [:index,:show]

  resources :asociations, only: [:index,:show]

  resources :personas, only: [:index,:show]

  resources :licitations, only: [:index,:show], path: 'licitaciones'

  resources :corporations, only: [:index,:show], path: 'sociedades'
  resources :brands, only: [:index,:show], path: 'marcas'
  resources :owners, only: [:index,:show]

  root :to => "home#index"
  match '/terminos-y-condiciones' => 'home#about', via: :get
  get "/sitemap" => redirect("https://s3.amazonaws.com/panadata/sitemaps/sitemap.xml.gz")
end
