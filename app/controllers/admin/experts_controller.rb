class Admin::ExpertsController < ApplicationController
  layout "admin"
  before_filter :admin_login

  def index
    url = URI.parse("#{ENV['API_LINK']}/v1/experts")
    http = Net::HTTP.new(url.host, url.port)

    request = Net::HTTP::Get.new(url.path, {'Content-Type' =>'application/json'})
    request.body = {
      token: ENV['API_TOKEN']
    }.to_json

    response = http.request(request)

    @experts = JSON.parse(response.body)
  end

  def edit
    url = URI.parse("#{ENV['API_LINK']}/v1/experts/#{params[:id]}")
    http = Net::HTTP.new(url.host, url.port)

    request = Net::HTTP::Get.new(url.path, {'Content-Type' =>'application/json'})
    request.body = { 
      token: ENV['API_TOKEN']
    }.to_json

    response = http.request(request)

    @expert = JSON.parse(response.body)["expert"]
  end

  def update
    url = URI.parse("#{ENV['API_LINK']}/v1/experts/#{params[:id]}")
    http = Net::HTTP.new(url.host, url.port)

    request = Net::HTTP::Patch.new(url.path, {'Content-Type' =>'application/json'})
    request.body = { 
      token: ENV['API_TOKEN'],
      expert: expert_params
    }.to_json

    http.request(request)

    redirect_to action: :index
  end

  def destroy
    url = URI.parse("#{ENV['API_LINK']}/v1/experts/#{params[:id]}")
    http = Net::HTTP.new(url.host, url.port)

    request = Net::HTTP::Delete.new(url.path, {'Content-Type' =>'application/json'})
    request.body = { 
      token: ENV['API_TOKEN']
    }.to_json

    http.request(request)

    redirect_to action: :index
  end

private

  def expert_params
    params.require(:poll_expert).permit(:id, :first_name, :last_name, :email, :job, :about, :color, :skill_title, :skill_description, :price, :tags, :slug)
  end
end