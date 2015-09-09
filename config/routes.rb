Rails.application.routes.draw do
  get 'signup' => 'users#new'
  get 'login' => 'sessions#new'
  post 'login'    => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  root 'top#index'
  get 'room' => 'users#question_room'
  
  resources :users, except: :new
  
  namespace :admin do
    root 'top#index'
  end
end
