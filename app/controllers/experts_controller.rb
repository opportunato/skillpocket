class ExpertsController < ApplicationController
  before_action :set_user, only: [:show]

  def show
  end

  def set_user
    handle = params[:id].match /@([\w-]+)/

    @user = User.approved.find_by_handle(handle[1])
  end
end