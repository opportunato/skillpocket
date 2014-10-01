require 'rails_helper'

RSpec.describe User, 'Validations' do
  it { is_expected.to validate_presence_of(:first_name) }
  it { is_expected.to validate_presence_of(:last_name) }
end

RSpec.describe User, 'Associations' do
  it { is_expected.to have_one(:skill) }
end

RSpec.describe User, 'Delegations' do
  # it { is_expected.to delegate(:color).to(:skill) }
  it { is_expected.to delegate(:price).to(:skill) }
  it { is_expected.to delegate(:categories).to(:skill).with_prefix(:skill) }
  it { is_expected.to delegate(:tags).to(:skill).with_prefix(:skill) }
  it { is_expected.to delegate(:description).to(:skill).with_prefix(:skill) }
  it { is_expected.to delegate(:title).to(:skill).with_prefix(:skill) }
end

RSpec.describe User do
  describe "#full_name" do
    it "returns concatenated first and last name" do
      user = create(:user)

      expect(user.full_name).to eq(user.first_name + " " + user.last_name)
    end
  end
end
