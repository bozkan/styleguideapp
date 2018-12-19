require 'sidekiq/web'
Rails.application.routes.draw do

  authenticated :user, -> user { user.email == 'nphaskins@gmail.com' } do
    mount Sidekiq::Web => '/sidekiq'
  end

  devise_for :users, skip: :registrations, path: '', path_names: { sign_in: 'login', sign_out: 'logout'}

  # Super Tenant
  constraints(:host => (Rails.env.production? ? 'styleguides.app' : 'lvh.me' ) ) do
    get 'register'      => 'register#index'
    post '/register'    => 'register#create'
    namespace :account do
      get '/' => '/accounts#index'
      resources :brands
    end
  end

  # Tenant
  constraints(SubDomainConstraint) do
    get '/'   => 'brands#show', as: :brand_root

    resources :logos
    resources :colors
    resources :color_categories
    resources :fonts
    resources :spacers
    resources :components

    namespace :settings do
      get '/'         => '/settings#index'
      post '/update'  => '/settings#update', as: :update
    end
  end

  root 'home#index'

end
