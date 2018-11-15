require 'rails_helper'

RSpec.describe NaturalPerson, type: :model do
  describe '#attributes' do
    it { is_expected.to respond_to :cpf }
    it { is_expected.to respond_to :fullname }
    it { is_expected.to respond_to :birthdate }
  end

  describe '#validation' do
    it { is_expected.to validate_presence_of :cpf }
    it { is_expected.to validate_presence_of :fullname }
    it { is_expected.to validate_presence_of :birthdate }
  end

  describe '#associations' do
    it { is_expected.to have_one(:account).dependent(:destroy) }
  end
end
