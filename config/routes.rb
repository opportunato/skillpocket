Rails.application.routes.draw do
  root 'landing#index'

  namespace :api, defaults: { format: "json" } do
    namespace :v1 do
      resources :experts, only: [:index, :show]
      resources :categories, only: [:index]
      resource :profile, only: [:show, :create, :update]
    end
  end

  get '/login', to: "sessions#new"
  get '/auth/twitter/callback', to: "sessions#create"

  get "/profile", to: "profile#index"
  get "/profile/edit", to: "profile#edit"
  patch "/profile", to: "profile#update"
end
