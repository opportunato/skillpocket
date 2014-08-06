class BerlinController < ApplicationController
  before_filter :admin_login, only: [:index, :show]
  layout "berlin", only: [:index, :show]

  def index
    url = URI.parse("#{ENV['API_LINK']}/v1/experts")
    http = Net::HTTP.new(url.host, url.port)

    request = Net::HTTP::Get.new(url.path, {'Content-Type' =>'application/json'})
    request.body = {
      token: ENV['API_TOKEN']
    }.to_json

    response = http.request(request)

    @experts = JSON.parse(response.body)
    @experts.shuffle!

    url = URI.parse("#{ENV['API_LINK']}/v1/categories")
    http = Net::HTTP.new(url.host, url.port)

    request = Net::HTTP::Get.new(url.path, {'Content-Type' =>'application/json'})

    response = http.request(request)

    @tags = JSON.parse(response.body)

    redirect_to action: :show, id: @experts.first['slug']
  end

  def show
    url = URI.parse("#{ENV['API_LINK']}/v1/experts")
    http = Net::HTTP.new(url.host, url.port)

    request = Net::HTTP::Get.new(url.path, {'Content-Type' =>'application/json'})
    request.body = {
      token: ENV['API_TOKEN']
    }.to_json

    response = http.request(request)

    @experts = JSON.parse(response.body)
    @experts.shuffle!

    @other_experts = @experts.reject { |expert| expert['slug'] == params[:id] }
    @current_expert = @experts.select { |expert| expert['slug'] == params[:id] }[0]

    @experts = @other_experts.unshift(@current_expert)

    url = URI.parse("#{ENV['API_LINK']}/v1/categories")
    http = Net::HTTP.new(url.host, url.port)

    request = Net::HTTP::Get.new(url.path, {'Content-Type' =>'application/json'})

    response = http.request(request)

    @tags = JSON.parse(response.body)   

    render action: :index 
  end
end
