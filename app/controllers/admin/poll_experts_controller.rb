class Admin::PollExpertsController < ApplicationController
  layout "admin"
  before_filter :admin_login

  has_scope :by_step

  def index
    @experts = apply_scopes(PollExpert).all.order("created_at DESC")
  end

  def destroy
    @poll_expert = PollExpert.find(params[:id])
    @poll_expert.destroy

    redirect_to action: :index
  end

  def edit
    @expert = PollExpert.find(params[:id])
  end
end