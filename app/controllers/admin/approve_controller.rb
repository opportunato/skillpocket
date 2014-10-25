class Admin::ApproveController < AdminController
  skip_before_action :authenticate!, only: [:index, :update]

  def index
    @users = User.all
  end

  def update
    redirect_to admin_approve_path
  end
end