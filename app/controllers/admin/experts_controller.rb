class Admin::ExpertsController < ApplicationController
  layout "admin"
  before_filter :admin_login

  def index
    url = URI.parse("http://api.skillpocket.com/v1/experts")
    http = Net::HTTP.new(url.host, url.port)

    request = Net::HTTP::Get.new(url.path, {'Content-Type' =>'application/json'})
    request.body = {
      token: ENV['API_TOKEN']
    }.to_json

    response = http.request(request)

    @experts = JSON.parse(response.body)
  end

  def destroy
    url = URI.parse("http://api.skillpocket.com/v1/experts/#{params[:id]}")
    http = Net::HTTP.new(url.host, url.port)

    request = Net::HTTP::Delete.new(url.path, {'Content-Type' =>'application/json'})
    request.body = { 
      token: ENV['API_TOKEN']
    }.to_json

    http.request(request)

    redirect_to action: :index
  end
end