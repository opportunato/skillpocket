class Admin::ApplicantsController < AdminController
  def index
    @applicants = User.experts.unapproved
    @experts = User.experts.approved
  end
end