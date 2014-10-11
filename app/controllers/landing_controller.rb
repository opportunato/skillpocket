class LandingController < ApplicationController
  before_filter :admin_login, only: :prelaunch_app
  layout "prelaunch", only: [:prelaunch_app, :show_prelaunch_app]

  def index
  end
end
