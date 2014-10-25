class LandingController < ApplicationController
  skip_before_action :authenticate!, only: [:index]

  def index
  end

  def faq
  end

  def about
  end
end
