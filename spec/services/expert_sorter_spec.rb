require 'rails_helper'

RSpec.describe ExpertSorter do
  context "when user doesn't have friended experts" do
    before :each do
      @expert_1 = create(:expert, created_at: 2.days.ago)
      @expert_2 = create(:expert, created_at: 1.days.ago)

      @experts = User.experts
      @user = create(:user)
    end

    it "should order experts by created_at" do
      @sorted_experts = ExpertSorter.new(@experts, @user).sort

      expect(@sorted_experts.map { |expert| expert.id }).to eq([@expert_2.id, @expert_1.id])
    end
  end

  context "when user has friended experts" do
    before :each do
      @expert_1 = create(:expert, created_at: 2.days.ago)
      @expert_2 = create(:expert, created_at: 1.days.ago)
      @expert_3 = create(:expert, created_at: 4.days.ago)
      @expert_4 = create(:expert, created_at: 3.days.ago)

      @experts = User.experts
      @user = create(:user_with_friended_experts, friended_experts: [@expert_1, @expert_2])
    end

    it "should first order friended experts" do
      @sorted_experts = ExpertSorter.new(@experts, @user).sort

      expect(@sorted_experts.map { |expert| expert.id }).to eq([@expert_2.id, @expert_1.id, @expert_4.id, @expert_3.id])
    end
  end

  # context "when user has friended expert followers" do
  #   before :each do
  #     @expert_1 = create(:expert, created_at: 2.days.ago)
  #     @expert_2 = create(:expert, created_at: 1.days.ago)
  #     @expert_3 = create(:expert, created_at: 4.days.ago)
  #     @expert_4 = create(:expert, created_at: 3.days.ago)

  #     @experts = User.experts
  #     @user = create(:user_with_friended_experts, friended_experts: [@expert_1, @expert_2])
  #   end

  #   it "should first order friended experts" do
  #     @sorted_experts = ExpertSorter.new(@experts, @user).sort

  #     expect(@sorted_experts.map { |expert| expert.id }).to eq([@expert_2.id, @expert_1.id, @expert_4.id, @expert_3.id])
  #   end
  # end
end