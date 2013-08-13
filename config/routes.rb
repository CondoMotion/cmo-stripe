CmoStripe::Application.routes.draw do
  resources :documents
  resources :news

  mount StripeEvent::Engine => '/stripe'
  
  get '/',        to: 'sites#show',                      constraints: lambda { |r| r.subdomain.present? && r.subdomain != 'www' }
  get '/edit',    to: 'sites#edit',    as: :edit_site,   constraints: lambda { |r| r.subdomain.present? && r.subdomain != 'www' }
  get '/sign_up', to: 'signups#new',   as: :site_signup, constraints: lambda { |r| r.subdomain.present? && r.subdomain != 'www' }

  get ':id',      to: 'pages#show',    as: :page,        constraints: lambda { |r| r.subdomain.present? && r.subdomain != 'www' }
  put ':id',      to: 'pages#update',                    constraints: lambda { |r| r.subdomain.present? && r.subdomain != 'www' }
  delete ':id',   to: 'pages#destroy'

  get "company",        to: "companies#show",       as: :show_company
  get "company/edit",   to: "companies#edit",       as: :edit_company

  get "pricing",        to: "home#pricing",         as: :pricing,         constraints: lambda { |r| !r.subdomain.present? or r.subdomain == 'www' }
  get "about",          to: "home#about",           as: :about,           constraints: lambda { |r| !r.subdomain.present? or r.subdomain == 'www' }
  get "featured-sites", to: "home#featured_sites",  as: :featured_sites,  constraints: lambda { |r| !r.subdomain.present? or r.subdomain == 'www' }
  get "contact",        to: "home#contact",         as: :contact,         constraints: lambda { |r| !r.subdomain.present? or r.subdomain == 'www' }


  root to: "news#index", constraints: lambda { |r| r.env["warden"].authenticate? }
  root to: "home#index"

  devise_for :users, controllers: { registrations: 'registrations' }
  devise_scope :user do
    get 'users/edit(/:tab)',            to: 'registrations#edit'
    get 'sign_up/:plan',                to: 'registrations#new'
    get 'sign_in',                      to: 'devise/sessions#new',        as: :new_user_session
    put 'update_plan',                  to: 'registrations#update_plan'
    put 'update_card',                  to: 'registrations#update_card'
    post 'company_user_registration',   to: 'users#create',               as: :company_user_registration
  end

  resources :signups, only: [:new, :create]
  resources :users
  resources :messages
  resources :companies
  resources :sites
  resources :pages do
    collection { post :sort }
  end


end