Rails.application.routes.draw do
  # Super Tenant
  constraints(:host => (Rails.env.production? ? 'styleguides.app' : 'lvh.me' ) ) do

  end

  # Tenant
  constraints(SubDomainConstraint) do
    get '/'   => 'colors#index', as: :brand_root

    resources :colors
    resources :fonts
    resources :spacers
    resources :components
  end

  root 'home#index'

end
