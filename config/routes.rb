Rails.application.routes.draw do
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
  resources :quotations
  resources :restaurants do
    resources :menus
  end
  resources :profile
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get '/solutions', to: 'site#solutions'
  root to: 'site#index'
end


