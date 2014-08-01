Rails.application.routes.draw do
  root 'landing#index'

  get "/prelaunch", to: "landing#prelaunch"
  get "/Prelaunch", to: "landing#prelaunch"
  get "/success", to: "landing#success"
  get "/thankyou", to: "landing#thankyou"
  post "/prelaunch_submit", to: "landing#prelaunch_submit"
  post "/mail_submit", to: "landing#mail_submit"

  namespace :admin do
    resources :pre_users, only: [:index, :destroy]
    patch "/mark_as_read", to: "pre_users#mark_as_read"
  end
end
