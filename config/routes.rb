Rails.application.routes.draw do
  root to: 'pages#home'
  devise_for :admins, controllers: { registrations: 'users/registrations' }
  devise_for :users, controllers: { registrations: 'users/registrations' }
  resources :users do
    resource :profile
    resource :pet
  end
  resources :admins do
    resource :profile
  end
  get 'pets', to: 'users#petindex'
  get 'pets/:id' , to: 'users#petshow'
  get 'verification', to: 'users#verification'
  get 'about', to: 'pages#about'
  resources :contacts, only: :create
  get 'contact-us', to: 'contacts#new', as: 'new_contact'
end
