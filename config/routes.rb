Rails.application.routes.draw do
  root 'landing#index'

  get "/poll", to: "landing#poll"
  get "/success", to: "landing#success"
  get "/thankyou", to: "landing#thankyou"
  post "/poll_submit", to: "landing#poll_submit"
  post "/mail_submit", to: "landing#mail_submit"

  match "/admin/*path" => "admin/poll#index", via: [:get], constraints: { format: 'html' }
end
