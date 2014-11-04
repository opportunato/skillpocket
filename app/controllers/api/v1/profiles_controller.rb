class Api::V1::ProfilesController < ApiController
  skip_before_action :authenticate!, only: [:create]
  before_action :get_profile, except: [:create]

  def create
    user = UserCreator.perform params.permit(:token, :secret).symbolize_keys
    render json: { token: user.access_token }, status: 201
  end

  def show
  end

  def update
    @profile.update user_params
    render nothing: true, status: 201
  end

  def pushtoken
    @profile.update params.permit(:ios_device_token)
    render nothing: true, status: 202
  end

  def location
    @profile.update params.permit(:latitude, :longitude)
    render nothing: true, status: 200
  end

private
  def get_profile
    @profile = current_user
  end

  # TODO: allow to update photo and skill

  def user_params
    params.permit(:full_name, :email, :job, :about,
             :website_url, :linkedin_url,
             :behance_url, :github_url, :stackoverflow_url)
  end
end
