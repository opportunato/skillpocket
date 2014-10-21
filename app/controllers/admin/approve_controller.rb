class Admin::ApproveController < AdminController
  def index
    @users = User.all
  end

  def update
    user = User.find_by(twitter_handle: params[:handle])
    user.present? && user.approve

    redirect_to admin_approve_path
  end
end