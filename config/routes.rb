Rails.application.routes.draw do
  root 'landing#index'

  namespace :api, defaults: { format: "json" } do
    namespace :v1 do
      resources :experts, only: [:index, :show]
      resources :categories, only: [:index]
      resource :profile, only: [:show, :create, :update]
    end
  end

  get '/auth/twitter/callback', to: "sessions#create"

  get "onboarding/step1", to: "onboarding#step1"
  get "onboarding/step2", to: "onboarding#step2"
  post "onboarding/step2", to: "onboarding#step2_submit"
  get "onboarding/step3", to: "onboarding#step3"
  post "onboarding/step3", to: "onboarding#step3_submit"

  get "profile", to: "profile#index"
end
