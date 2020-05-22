Rails.application.routes.draw do
  root 'toppages#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  resources :users, only: [:show, :create, :edit, :update]
  
  resources :goals, only: [:index, :new, :create, :edit, :update, :destroy] do
    resources :good_habits, only: [:new, :create, :destroy]
    resources :bad_habits, only: [:new, :create, :destroy]
  end
  
  resources :good_logs, only: [:create, :destroy]
  resources :logs, only: [:index]
end
