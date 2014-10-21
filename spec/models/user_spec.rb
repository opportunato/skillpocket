require 'rails_helper'

RSpec.describe User do
  it_behaves_like Messageable, :user

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:full_name) }
  end

  describe 'Associations' do
    it { is_expected.to have_one(:skill) }
  end

  describe 'Delegations' do
    it { is_expected.to delegate(:price).to(:skill) }
    it { is_expected.to delegate(:categories).to(:skill).with_prefix(:skill) }
    it { is_expected.to delegate(:tags).to(:skill).with_prefix(:skill) }
    it { is_expected.to delegate(:title).to(:skill).with_prefix(:skill) }
  end
end
