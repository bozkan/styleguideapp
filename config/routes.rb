Rails.application.routes.draw do

  devise_for :users, skip: :registrations

  # Super Tenant
  constraints(:host => (Rails.env.production? ? 'styleguides.app' : 'lvh.me' ) ) do
    get '/account' => 'accounts#index'
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
  end

  root 'home#index'

end
