class Admin::PreUsersController < ApplicationController
  layout "admin"
  before_filter :admin_login

  def index   
  end
end