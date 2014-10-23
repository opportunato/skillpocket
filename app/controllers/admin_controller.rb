class AdminController < ApplicationController
  skip_before_action :authenticate!
  before_action :authenticate_admin!
end