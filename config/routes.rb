Rails.application.routes.draw do
 
  get 'password_resets/edit'

  get 'password_resets/new'

  get 'password_resets/create'

  #root: to => 'welcome#index'
  #get '/meetings' => 'events#index', :as => "meetings"
  #get 'meetings/:id', :to => 'events#show'
  root 'users#new'
  
  get 'sessions/new'
  get '/signup',     to: 'users#new'
  post '/signup',    to: 'users#create'
  get '/login',      to: 'sessions#new'
  post '/login',     to: 'sessions#create'
  delete '/logout',  to: 'sessions#destory' 
  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
  resources :microposts, only: [:create, :destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
