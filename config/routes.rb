Rails.application.routes.draw do
  root 'landing#index'

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
end
