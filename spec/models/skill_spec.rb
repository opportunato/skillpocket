require 'rails_helper'

RSpec.describe Skill do
  describe 'Validations' do
    it { is_expected.to validate_presence_of(:price) }
    it { is_expected.to validate_presence_of(:title) }
  end

  describe 'Associations' do
    it { is_expected.to belong_to(:expert).class_name('User') }
  end
end
