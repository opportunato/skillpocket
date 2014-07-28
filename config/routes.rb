Rails.application.routes.draw do
  root 'landing#index'

  get "/poll", to: "landing#poll"
  get "/success", to: "landing#success"
  post "/poll_submit", to: "landing#poll_submit"
end
