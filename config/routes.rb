Rails.application.routes.draw do
  get 'news/show'
  get 'main/index'
  get '/news', to: 'news#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'main#index'
end
