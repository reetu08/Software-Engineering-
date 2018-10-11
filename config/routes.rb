Rails.application.routes.draw do
  resources :potential_buyers
  resources :inquiry_replies
  resources :inquiries
  resources :houses
  resources :companies do
    member do
      get 'join'
      get 'leave'
    end
  end

  root to: 'visitors#index'
  devise_for :users, { :controllers => { :registrations => 'registrations' } }

  resources :users
  resources :realtors
  post '/users/manual', to: 'users#manual_create'
end
