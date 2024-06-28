Rails.application.routes.draw do
  root to: 'home#index'
  devise_for :users

  resources :courses, only: [:index, :show] do
    resources :lessons, only: [:show]
  end

  resources :enrollments, only: [:create, :destroy]

  resources :experiments, only: [:show] do
    collection do
      post :combine
    end
    resources :questions, only: [] do
      resources :answers, only: [:create]
    end
  end

  resources :xps, only: [:index]
  resources :badges, only: [:index]
  resources :user_badges, only: [:index]
end
