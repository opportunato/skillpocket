class LandingController < ApplicationController
  def index
  end

  def prelaunch
    @current_page = cookies[:poll_page].present? ? cookies[:poll_page].to_i : 1
  end

  def prelaunch_submit
    step = params[:page].to_i

    if [1, 2, 3].include?(step)
      if step == 1
        token = SecureRandom.uuid

        @poll_expert = PollExpert.create(email: expert_params_1[:email], token: token, step: 1)

        cookies.signed[:token] = token

        cookies[:poll_page] = 2

      elsif step == 2
        @poll_expert = PollExpert.find_by(token: cookies.signed[:token])
        @poll_expert.update(expert_params_2.merge({
          step: 2
        }))

        cookies[:poll_page] = 3
      elsif step == 3
        @poll_expert = PollExpert.find_by(token: cookies.signed[:token])
        @poll_expert.update(expert_params_3.merge({
          step: 3
        }))

        cookies.delete :token
        cookies.delete :poll_page
      end

      if step == 3
        redirect_to action: :success
      else
        render json: { success: true }
      end
    end
  end

  def mail_submit
    user = PreUser.create(pre_user_params)

    redirect_to action: :thankyou
  end

  def success
  end

  def thankyou
  end

private

  def expert_params_1
    params.require(:expert).permit(:email)
  end

  def expert_params_2
    params.require(:expert).permit(:full_name, :job, :site_link, :twitter_link, :linkedin_link)
  end

  def expert_params_3
    params.require(:expert).permit(:skill_title, :skill_description, :price, :tags, :image)
  end

  def pre_user_params
    params.require(:user).permit(:email)
  end
end
