CmoStripe::Application.routes.draw do
  mount StripeEvent::Engine => '/stripe'
  
  get ':id', to: 'pages#show', as: :page, constraints: lambda { |r| r.subdomain.present? && r.subdomain != 'www' }
  put ':id', to: 'pages#update'
  delete ':id', to: 'pages#destroy'
  match '', to: 'sites#show', constraints: lambda { |r| r.subdomain.present? && r.subdomain != 'www' }

  get "company",        to: "companies#show",       as: :show_company
  get "company/edit",   to: "companies#edit",       as: :edit_company
  get "company/users",  to: "companies#users",      as: :company_users
  get "dashboard",      to: "dashboard#index",      as: :dashboard

  get "pricing",        to: "home#pricing",         as: :pricing
  get "about",          to: "home#about",           as: :about
  get "featured-sites", to: "home#featured_sites",  as: :featured_sites
  get "contact",        to: "home#contact",         as: :contact

  authenticated :user do
    root to: 'home#index'
  end
  root to: "home#index"
  devise_for :users, controllers: { registrations: 'registrations' }
  devise_scope :user do
    get 'sign_up/:plan',                to: 'registrations#new'
    put 'update_plan',                  to: 'registrations#update_plan'
    put 'update_card',                  to: 'registrations#update_card'
    post 'company_user_registration',   to: 'registrations#company_user_registration',   as: :company_user_registration
  end

  resources :users
  resources :messages
  resources :companies
  resources :sites
  resources :pages do
    collection { post :sort }
  end

end