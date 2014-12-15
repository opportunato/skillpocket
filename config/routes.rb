Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  root 'experts#index'

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
    get "/applicants", to: "applicants#index"
  end

  get '/auth/twitter/callback', to: "sessions#create"

  get "onboarding/step/1", to: "onboarding#step1"
  get "onboarding/step/2", to: "onboarding#step2"
  post "onboarding/step/2", to: "onboarding#step2_submit"
  get "onboarding/step/3", to: "onboarding#step3"
  post "onboarding/step/3", to: "onboarding#step3_submit"
  get "onboarding/success", to: "onboarding#success"

  get "about", to: "landing#about"
  get "landing", to: "landing#index"
  get "faq", to: "landing#faq"

  get 'berlin/:id', to: redirect('/')
  get 'prelaunch', to: redirect('/')
  get 'Prelaunch', to: redirect('/')
  get '/uploads/user/000/000/347/photo/158c4278a1.png', to: redirect('/')

  resources :users, path: '', only: [:show, :edit, :update], constraints: { id: /@[\w-]+/ }

  get "/experts", to: "experts#index"
  get "/experts/:category", to: "experts#index", as: :category_experts
  get "/experts/:category/:city", to: "experts#index", as: :category_city_experts

  get "logout", to: "sessions#destroy"
end
