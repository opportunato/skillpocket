#encoding: utf-8

class Mailer < ActionMailer::Base
  include Roadie::Rails::Automatic
  default css: "mailer"
  layout "mail"

  def berlin_connect(connect, expert_email)
    @connect = connect

    mail(to: 'ryu.gordeyev@gmail.com', from: connect.email).deliver
  end
end