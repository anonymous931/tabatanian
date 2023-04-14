Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?

  root 'menus#index'

  resources :users do
    resource :relationships, only: %i[ create destroy ] do
      member do
        get :follower
        get :followed
      end
    end
  end

  resources :menus do
    resources :comments, only: %i[ create update destroy ], shallow: true
    get :favorites, on: :collection
    get :timer, on: :member
  end

  resources :favorites, only: %i[ create destroy ]

  resources :password_resets, only: %i[ new create edit update ]

  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'

  get 'terms', to: 'static_pages#terms'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
