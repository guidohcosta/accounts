require 'rails_helper'

RSpec.describe Head, type: :model do
  describe '#associations' do
    it { is_expected.to have_many(:branches).dependent :destroy }
    it { is_expected.to have_many(:contributions) }
    it { is_expected.to have_many(:transfers) }
    it { is_expected.to have_many(:contributions) }
    it { is_expected.to have_one(:account).dependent :destroy }
  end

  describe 'methods' do
    let(:head) { create(:head, account: build(:account)) }
    describe '#head_id' do
      it { expect(head.head_id).to eq head.id }
    end
  end
end
