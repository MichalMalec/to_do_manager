Rails.application.routes.draw do
  devise_for :users
  namespace :v1, defaults: { format: :json } do 
    resources :projects do
      resources :tasks
    end
    resource :sessions, only: [:create, :destroy]
    resources :users, only: [:create, :destroy]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
