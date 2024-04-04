Rails.application.routes.draw do
  # Route to access the test action in the private controller
  get 'private/test'
  
  # Route to access the get_token action in the sessions controller
  get '/get_token', to: 'sessions#get_token'

  # Resourceful routes for recipes
  resources :recipes

  # Devise routes for user authentication
  devise_for :users, 
    path: '', 
    path_names: {
      sign_in: 'login',
      sign_out: 'logout',
      registration: 'signup'
    },
    controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations'
    }
end
