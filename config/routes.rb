Rails.application.routes.draw do
  root 'landing#index'

  namespace :api, defaults: { format: "json" } do
    namespace :v1 do
      resources :experts, only: [:index, :show]
      resources :categories, only: [:index]
      resources :contacts, only: [:index]

      resource :profile, only: [:show, :create, :update] do
        post :pushtoken
        post :location
      end

      resources :message, only: [:show] do
        member do
          post :create
        end
        collection do
          get :unread
        end
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

  get "onboarding/step/1", to: "onboarding#step1"
  get "onboarding/step/2", to: "onboarding#step2"
  post "onboarding/step/2", to: "onboarding#step2_submit"
  get "onboarding/step/3", to: "onboarding#step3"
  post "onboarding/step/3", to: "onboarding#step3_submit"
  get "onboarding/success", to: "onboarding#success"

  get "about", to: "landing#about"
  get "faq", to: "landing#faq"

  resources :users, path: '', only: [:show, :edit, :update], constraints: { id: /@[\w-]+/ }

  get "logout", to: "sessions#destroy"
end
