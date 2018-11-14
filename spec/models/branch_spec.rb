require 'rails_helper'

RSpec.describe Branch, type: :model do
  describe '#validations' do
    it { is_expected.to validate_presence_of :head }
    it { is_expected.to validate_presence_of :parent }
  end

  describe '#associations' do
    it { is_expected.to have_one(:branch).dependent :destroy }
  end
end
