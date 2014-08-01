class Admin::PreUsersController < ApplicationController
  layout "admin"
  before_filter :admin_login

  has_scope :unread, type: :boolean

  def index
    @pre_users = apply_scopes(PreUser).all.order("created_at DESC")

    respond_to do |format|
      format.html
      format.csv { send_data @pre_users.to_csv }
    end
  end

  def destroy
    @pre_user = PreUser.find(params[:id])
    @pre_user.destroy

    redirect_to action: :index
  end

  def mark_as_read
    PreUser.update_all is_read: true

    redirect_to action: :index
  end
end