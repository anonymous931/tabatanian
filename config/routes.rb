Rails.application.routes.draw do
  root 'menus#index'
  resources :users do
    resource :relationships, only: %i[ create destroy ] do
      member do
        get :follower
        get :followed
      end
    end
  end

  resources :menus
  get 'login', to: 'user_sessions#new'
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
