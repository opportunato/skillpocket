class AdminController < ApplicationController
  load_and_authorize_resource
  skip_before_action :authenticate!
  before_action :authenticate_admin!
end