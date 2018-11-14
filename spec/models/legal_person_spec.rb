require 'rails_helper'

RSpec.describe LegalPerson, type: :model do
  describe '#attributes' do
    it { is_expected.to respond_to :cnpj }
    it { is_expected.to respond_to :corporate_name }
    it { is_expected.to respond_to :trading_name }
  end

  describe '#validation' do
    it { is_expected.to validate_presence_of :cnpj }
    it { is_expected.to validate_presence_of :corporate_name }
    it { is_expected.to validate_presence_of :trading_name }
  end

  describe '#associations' do
    it { is_expected.to have_one(:account).dependent(:destroy) }
  end
end
