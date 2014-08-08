#encoding: utf-8

class Mailer < ActionMailer::Base
  include Roadie::Rails::Automatic
  default css: "mailer"
  layout "mail"

  default from: "Skillpocket <hello@skillpocket.com>"

  def berlin_connect(connect, expert)
    @connect = connect
    @expert = expert

    mail(to: 'ryu.gordeyev@gmail.com', subject: 'Someone has requested to talk to you').deliver
  end
end