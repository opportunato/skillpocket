require 'rails_helper'

RSpec.describe Skill, 'Validations' do
  it { is_expected.to validate_presence_of(:description) }
  it { is_expected.to validate_presence_of(:price) }
  it { is_expected.to validate_presence_of(:title) }
end

RSpec.describe Skill, 'Associations' do
  it { is_expected.to belong_to(:expert).class_name('User') }
end
