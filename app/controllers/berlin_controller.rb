class BerlinController < ApplicationController
  before_filter :admin_login, only: [:index, :show]
  layout "berlin", only: [:index, :show]

  def index
    @experts = send_api_request("/v1/experts")
    @experts.shuffle!

    @categories = send_api_request("/v1/categories")

    if cookies[:berlin_shown]
      redirect_to action: :show, id: @experts.first['slug']
    else
      @connect = BerlinConnect.new
    end
  end

  def show
    @experts = send_api_request("/v1/experts")
    @experts.shuffle!

    @other_experts = @experts.reject { |expert| expert['slug'] == params[:id] }
    @current_expert = @experts.select { |expert| expert['slug'] == params[:id] }[0]

    @experts = @other_experts.unshift(@current_expert)

    @categories = send_api_request("/v1/categories")

    @connect = BerlinConnect.new

    render action: :index 
  end

  def connect
    berlin_connect = BerlinConnect.new(connect_params)

    if berlin_connect.save
      expert = send_api_request("/v1/experts/#{berlin_connect.expert_id}")['expert']
      Mailer.berlin_connect(berlin_connect, expert)

      render json: {
        success: true
      }
    else
      render json: {
        success: false
      }
    end
  end

private

  def connect_params
    params.require(:berlin_connect).permit(:expert_id, :name, :email, :topic)
  end

end
