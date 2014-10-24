class ApiController < ApplicationController
  skip_before_action :verify_authenticity_token
  skip_before_action :authenticate_admin!
  skip_before_action :authenticate!
end
