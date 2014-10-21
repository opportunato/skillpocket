class Api::V1::ProfilesController < ApiController
  before_filter :authenticate, except: [:create]
  before_filter :get_profile, except: [:create]

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
    @profile = @current_user
  end

  # TODO: allow to update photo and skill

  def user_params
    params.permit(:first_name, :last_name, :email, :job, :about,
             :website_link, :twitter_link, :linkedin_link,
             :behance_link, :github_link, :stackoverflow_link)
  end
end
