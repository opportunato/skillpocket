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

private
  def get_profile
    # @profile = current_user
    @profile = User.find(9)
  end

  # TODO: allow to update photo and skill

  def user_params
    params.permit(:full_name, :email, :job, :about,
             :website_url, :twitter_url, :linkedin_url,
             :behance_url, :github_url, :stackoverflow_url)
  end
end
