Rails.application.routes.draw do
  root 'landing#index'

  get "/prelaunch", to: "landing#prelaunch"
  get "/Prelaunch", to: "landing#prelaunch"
  get "/success", to: "landing#success"
  get "/thankyou", to: "landing#thankyou"
  post "/prelaunch_submit", to: "landing#prelaunch_submit"
  post "/mail_submit", to: "landing#mail_submit"

  match "/admin/*path" => "admin/poll#index", via: [:get], constraints: { format: 'html' }
end
