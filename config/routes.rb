Rails.application.routes.draw do
  get 'user/index'
  get '/news', to: 'news#index'
  get '/basics', to: 'basics#quotations'
  get '/planning', to: 'basics#index'
  match '/basics', :to => "basics#quotations", :via => [:get, :post]
  resources :basics
  resources :quotations
  resources :user
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'site#index'
end
