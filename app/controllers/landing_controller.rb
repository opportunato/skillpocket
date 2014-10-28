class LandingController < ApplicationController
  skip_before_action :authenticate!

  def index
  end

  def faq
  end

  def about
  end
end
