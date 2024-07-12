Rails.application.routes.draw do
  get 'badges/index'
  get 'learn', to: 'reactions#index'
  get 'playground', to: 'elements#index'
  get 'badges', to: 'badges#index'
  root to: 'home#index'
  devise_for :users

  get 'profile', to: 'users#profile', as: 'user_profile'
  get 'xp/current', to: 'xp#current'
  
  resources :xps, only: [:index]
  resources :badges, only: [:index]
  resources :reactions, only: [:index, :show] do
    member do
      get 'elements', defaults: { format: :json }
    end
  end
  resources :user_badges, only: [:index]
end
