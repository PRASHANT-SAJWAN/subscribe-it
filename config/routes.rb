Rails.application.routes.draw do
  root "products#index"

  resources :products
  post 'checkout/create' => 'checkout#create'

  get '/login' => 'users#login'
  post '/login' => 'users#login'

  get '/signup' => 'users#signup'
  post '/signup' => 'users#signup'

end
