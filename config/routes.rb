CmoStripe::Application.routes.draw do
  mount StripeEvent::Engine => '/stripe'

  get "pricing",        to: "home#pricing",         as: :pricing
  get "about",          to: "home#about",           as: :about
  get "featured-sites", to: "home#featured_sites",  as: :featured_sites
  get "contact",        to: "home#contact",         as: :contact

  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  devise_for :users, :controllers => { :registrations => 'registrations' }
  devise_scope :user do
    get 'sign_up/:plan', :to => 'registrations#new'
    put 'update_plan', :to => 'registrations#update_plan'
    put 'update_card', :to => 'registrations#update_card'
  end
  resources :users
  resources :messages
end