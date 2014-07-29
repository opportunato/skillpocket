class Admin::PollController < ApplicationController
  layout "admin"
  before_filter :admin_login

  def index
    
  end
end