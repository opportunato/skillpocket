class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

protected

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
