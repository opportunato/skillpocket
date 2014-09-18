class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_filter :set_current_user

protected

  def set_current_user
    @current_user = User.find_by(id: session[:user_id])
  end

  def admin_login
    if Rails.env.production?
      authenticate_or_request_with_http_basic do |u, p| 
        u == ENV['USERNAME'] && Digest::SHA1.hexdigest(p) == ENV['PASSWORD_HASH']
      end
    end
  end

  def send_api_request(path, type="get")
    url = URI.parse("#{ENV['API_LINK']}#{path}")
    http = Net::HTTP.new(url.host, url.port)

    request = Net::HTTP::Get.new(url.path, {'Content-Type' =>'application/json'})
    request.body = {
      token: ENV['API_TOKEN']
    }.to_json

    response = http.request(request)

    return JSON.parse(response.body)
  end

  def absolute_attachment_url(attachment_name, attachment_style = :original)
    "#{request.protocol}#{request.host_with_port}#{attachment_name.url(attachment_style)}"
  end
end
