Rails.application.routes.draw do
  devise_for :users, skip: [:sessions]
  root to:'pages#home'
  get 'about', to: 'pages#about'
  resources :contacts, only: :create
  get 'contact-us', to: 'contacts#new', as: 'new_contact'
  devise_scope :user do
    get 'login', to: 'devise/sessions#new', as: :new_user_session
    post 'login', to: 'devise/sessions#create', as: :user_session
    
    delete 'logout', to: 'devise/sessions#destroy', as: :destroy_user_session
  end
end

