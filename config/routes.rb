Rails.application.routes.draw do
  resources :cart_items
  resources :carts, :path => "/cart"
  resources :cart
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, controllers: { registrations: 'registrations' }
  get 'user/index'
  get '/news', to: 'news#index'
  get '/basics', to: 'basics#quotations'
  get '/admin' , to: 'basics#admin'
  get '/planning', to: 'basics#index'
  match '/basics', :to => "basics#quotations", :via => [:get, :post]
  resources :basics
  resources :orders
  resources :quotations
  resources :wait_queue
  resources :restaurants do
    resources :restaurant_tables
    resources :menus
    resources :users, :path => "/staff"
  end
  # post '/restaurants/:restaurant_id/restaurant_tables/:id' 
  resources :profile
  post '/restaurants/:id' => 'restaurants#show'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/solutions', to: 'site#solutions'
  get '/browse', to: 'restaurants#browse'
  root to: 'site#index'

  devise_scope :user do
    get '/sign-in' => "devise/sessions#new", :as => :login
  end
end


