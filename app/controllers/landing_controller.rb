class LandingController < ApplicationController
  def index
  end

  def poll
  end

  def poll_submit
    temp_image = TempImage.create(image: params[:image])

    data = {
      expert: expert_params.merge({
        image: absolute_attachment_url(temp_image.image)
      }),
      token: ENV['API_TOKEN']
    }

    url = URI.parse(ENV['POLL_LINK'])
    http = Net::HTTP.new(url.host, url.port)

    request = Net::HTTP::Post.new(url.path, {'Content-Type' =>'application/json'})
    request.body = data.to_json

    response = http.request(request)

    redirect_to action: :success
  end

  def success
  end

private

  def expert_params
    params.require(:expert).permit(:twitter_link, :linkedin_link, :site_link, :text_title, :tags, :price)
  end
end
