class Admin::LoginController < ApplicationController
  skip_before_action :authenticate_admin!, only: [:new, :create]
  skip_before_action :authenticate!, only: [:new, :create]

  def new
    if is_admin?
      redirect_to :root
    end
  end

  def create
    warden.authenticate!(:password, scope: :admin)

    redirect_to admin_approve_path
  end
end