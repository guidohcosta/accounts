require 'rails_helper'

RSpec.describe Contribution, type: :model do
  describe '#attributes' do
    it { is_expected.to respond_to :head }
    it { is_expected.to respond_to :code }
    it { is_expected.to respond_to :reversed }
    it { is_expected.to respond_to :amount }
  end

  describe '#association' do
    it { is_expected.to belong_to :head }
  end
end
