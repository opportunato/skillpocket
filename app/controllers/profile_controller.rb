class ProfileController < ApplicationController
  skip_before_action :authenticate!, only: [:index]
  before_action :set_user, only: [:index]

  def index
  end

private

  def set_user
    @user = User.last
  end
end
