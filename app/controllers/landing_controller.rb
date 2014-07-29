class LandingController < ApplicationController
  def index
  end

  def poll
    @current_page = cookies[:poll_page].present? ? cookies[:poll_page].to_i : 1
  end

  def poll_submit
    step = params[:page].to_i

    if [1, 2, 3, 4].include?(step)
      if step == 1
        token = SecureRandom.uuid

        @temp_user = TempUser.create(email: expert_params_1[:email], token: token)

        cookies.signed[:token] = token

        cookies[:poll_page] = 2

        data = {
          token: cookies[:token],
          expert: expert_params_1,
          step: 1,
          api_token: ENV['API_TOKEN']
        }
      elsif step == 2
        @temp_user = TempUser.find_by(token: cookies[:token])

        cookies[:poll_page] = 3

        data = {
          token: cookies[:token],
          expert: expert_params_2,
          step: 2,
          api_token: ENV['API_TOKEN']
        }
      elsif step == 3
        @temp_user = TempUser.find_by(token: cookies[:token])

        cookies[:poll_page] = 4

        data = {
          token: cookies[:token],
          expert: expert_params_3,
          step: 3,
          api_token: ENV['API_TOKEN']
        }
      elsif step == 4
        @temp_user = TempUser.find_by(token: cookies[:token])
        # if params[:image]
        #   temp_image = TempImage.create(image: params[:image])
        # end

        data = {
          token: cookies[:token],
          expert: expert_params_4,
          step: 4,
          api_token: ENV['API_TOKEN']
        }

        cookies.delete :token
        cookies.delete :poll_page
      end

      url = URI.parse(ENV['POLL_LINK'])
      http = Net::HTTP.new(url.host, url.port)

      request = Net::HTTP::Post.new(url.path, {'Content-Type' =>'application/json'})
      request.body = data.to_json

      # response = http.request(request)

      if step == 4
        redirect_to action: :success
      else
        render json: { success: true }
      end
    end
  end

  def success
  end

private

  def expert_params_1
    params.require(:expert).permit(:email, :full_name)
  end

  def expert_params_2
    params.require(:expert).permit(:job, :site_link, :twitter_link, :linkedin_link)
  end

  def expert_params_3
    params.require(:expert).permit(:skill_title, :skill_description)
  end

  def expert_params_4
    params.require(:expert).permit(:price, :tags)
  end
end
