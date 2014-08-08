#encoding: utf-8

class Mailer < ActionMailer::Base
  include Roadie::Rails::Automatic
  default css: "mailer"
  layout "mail"

  default from: "Skillpocket <hello@skillpocket.com>"

  def berlin_connect(connect, expert)
    @connect = connect
    @expert = expert

    @first_name = connect.name.split(' ')[0]

    mail(to: expert['email'], subject: "#{@first_name} would like to meet with you!").deliver
  end
end