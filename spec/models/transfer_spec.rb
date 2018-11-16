require 'rails_helper'

RSpec.describe Transfer, type: :model do
  describe '#associations' do
    it { is_expected.to belong_to :from }
    it { is_expected.to belong_to :to }
  end

  describe '#attributes' do
    it { is_expected.to respond_to :from }
    it { is_expected.to respond_to :to }
    it { is_expected.to respond_to :amount }
    it { is_expected.to respond_to :reversed }
  end
end
