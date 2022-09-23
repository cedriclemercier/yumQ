Rails.application.routes.draw do
  get '/news', to: 'news#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'site#index'
end
