Rails.application.routes.draw do
  root 'landing#index'

  namespace :api, defaults: { format: "json" } do
    namespace :v1 do
      resources :experts, only: [:index, :show]
      resources :categories, only: [:index]
      resource :profile, only: [:show, :create, :update]
      resources :message, only: [:show] do
        member do
          post :create
        end
        collection do
          get :unread
        end
      end
      resources :contacts, only: [:index, :show] do
      end
    end
  end

  namespace :admin do
    get "/login", to: "login#new"
    post "/login", to: "login#create"
    get "/approve", to: "approve#index"
    post "/approve", to: "approve#update"
  end

  get '/auth/twitter/callback', to: "sessions#create"

  get "onboarding/step1", to: "onboarding#step1"
  get "onboarding/step2", to: "onboarding#step2"
  post "onboarding/step2", to: "onboarding#step2_submit"
  get "onboarding/step3", to: "onboarding#step3"
  post "onboarding/step3", to: "onboarding#step3_submit"
  get "onboarding/success", to: "onboarding#success"

  get "profile", to: "profile#index"
  get "profile/edit", to: "profile#edit"
  post "profile", to: "profile#update"

  get "logout", to: "sessions#destroy"
end
