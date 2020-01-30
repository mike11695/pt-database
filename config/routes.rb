Rails.application.routes.draw do
  default_url_options :host => "www.pettp.com"
  root to: 'pages#home'
  devise_for :admins, controllers: { registrations: 'admins/registrations' }
  devise_for :users, controllers: { registrations: 'users/registrations' }
  resources :users do
    resource :profile
    resource :pet
  end
  resources :admins do
    resource :profile
  end
  resources :conversations do
    resources :messages
  end
  get 'pets', to: 'users#petindex'
  get 'pets/:id' , to: 'users#petshow'
  get 'verification', to: 'users#verification'
  get 'about', to: 'pages#about'
  resources :contacts, only: :create
  get 'contact-us', to: 'contacts#new', as: 'new_contact'
  resources :reports
  get 'rules', to: 'pages#rules'
  get '/admins/sign_up' => redirect('pages#home')
end
