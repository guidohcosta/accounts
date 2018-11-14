require 'rails_helper'

RSpec.describe Head, type: :model do
  describe '#associations' do
    it { is_expected.to have_many(:branches).dependent :destroy }
  end
end
