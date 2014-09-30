Rails.application.routes.draw do
  root 'landing#index'

  namespace :api, defaults: { format: "json" } do
    namespace :v1 do
      resources :experts, only: [:index, :show]
      resources :categories, only: [:index]
      resource :profile, only: [:show, :create, :update]
    end
  end

  get "/prelaunch", to: "landing#prelaunch"
  get "/Prelaunch", to: "landing#prelaunch"
  get "/success", to: "landing#success"
  get "/thankyou", to: "landing#thankyou"
  post "/prelaunch_submit", to: "landing#prelaunch_submit"
  post "/mail_submit", to: "landing#mail_submit"
  get "/berlin", to: "berlin#index"
  get "/berlin/apply", to: "berlin#index"
  get "/berlin/:id", to: "berlin#show"
  post "/berlin_connect", to: "berlin#connect"

  namespace :admin do
    resources :experts, only: [:index, :destroy, :edit, :update]
    resources :pre_users, only: [:index, :destroy]
    resources :berlin_connects, only: [:index]
    resources :poll_experts, only: [:index, :edit, :create, :destroy]
    patch "/mark_as_read", to: "pre_users#mark_as_read"
  end

  get '/login', to: "sessions#new"
  get '/auth/twitter/callback', to: "sessions#create"

  get "/profile", to: "profile#index"
  get "/profile/edit", to: "profile#edit"
  patch "/profile", to: "profile#update"
end
