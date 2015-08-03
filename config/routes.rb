Rails.application.routes.draw do
  resources :wards
  resources :stakes
  resources :regions
  resources :users
  resources :events
  resources :accounts

  get 'login'     => 'session#new', as: :login
  post 'login'    => 'session#create'
  get 'logout'    => 'session#destroy', as: :logout

  # Confirmation routes
  get 'confirmation' => 'confirmation#index', as: :confirmation
  post 'activate/:id' => 'users#activate', as: :activate_user
  post 'deactivate/:id' => 'users#deactivate', as: :deactivate_user

  # You can have the root of your site routed with "root"
  root 'session#home'
end
