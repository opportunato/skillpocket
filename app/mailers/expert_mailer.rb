#encoding: utf-8

class ExpertMailer < ActionMailer::Base
  layout "mail"

  default from: "Skillpocket <hello@skillpocket.com>"

  def web_message(message)
    @message = message
    @expert = message.expert

    subject = "#{@expert.first_name}, you got a new request on Skillpocket from #{@message.full_name}!"

    if @expert.email.present?
      mail(to: @expert.email, from: "hello@skillpocket.com", subject: subject).deliver
    end
  end
end