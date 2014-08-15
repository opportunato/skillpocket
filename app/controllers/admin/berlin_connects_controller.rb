class Admin::BerlinConnectsController < ApplicationController
  layout "admin"
  before_filter :admin_login

  def index
    @berlin_connects = BerlinConnect.order("created_at DESC")
  end
end