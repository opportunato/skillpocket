class Api::V1::ProfileController < ApiController 
  before_filter :authenticate, except: [:create]

  def index
    @profile = @current_user
  end

  def create
    if params[:token].nil? || params[:secret].nil?
      render nothing: true, status: 400
    else
      user = ProfileCreator.perform(token: params[:token], secret: params[:secret])

      render json: {
        token: user.access_token
      }, status: 201
    end
  end

  def update
    render json: {
      token: user.access_token
    }, status: 201
  end

private

  def profile_params
    params.require(:token, :secret)
  end
end
