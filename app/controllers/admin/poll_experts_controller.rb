class Admin::PollExpertsController < ApplicationController
  layout "admin"
  before_filter :admin_login

  has_scope :by_step

  def index
    @experts = apply_scopes(PollExpert).all.order("created_at DESC")
  end

  def destroy
    @poll_expert = PollExpert.find(params[:id])
    @poll_expert.destroy

    redirect_to action: :index
  end

  def edit
    @expert = PollExpert.find(params[:id])

    
  end

  def create
    @poll_expert = PollExpert.find(expert_params[:id])

    data = {
      token: ENV['API_TOKEN'],
      expert: expert_params.merge({
        image: @poll_expert.image.url
      })
    }

    url = URI.parse("#{ENV['API_LINK']}/v1/experts")
    http = Net::HTTP.new(url.host, url.port)

    request = Net::HTTP::Post.new(url.path, {'Content-Type' =>'application/json'})
    request.body = data.to_json

    response = http.request(request)

    response = JSON.parse(response.body)

    binding.pry

    if response["success"]
      @poll_expert.update(expert_created: true)
      redirect_to action: :index
    else
      @expert = @poll_expert

      render action: :edit
    end
  end

private

  def expert_params
    params.require(:poll_expert).permit(:id, :first_name, :last_name, :email, :job, :about, :color, :skill_title, :skill_description, :price, :tags)
  end
end