class WebMessagesController < ApplicationController
  skip_before_action :authenticate!, only: [:create]

  def create
    web_message = WebMessage.new(message_params)

    if current_user.present? && current_user.id
      web_message.user = current_user
    end

    web_message.save!

    if web_message.persisted?
      ExpertMailer.web_message(web_message)
    end

    render plain: "OK"
  end

private

  def message_params
    params.require(:web_message).permit(
      :email, :expert_id, :body, :full_name
    )
  end
end