require 'rails_helper'

RSpec.describe Account, type: :model do
  describe "#attributes" do
    it { is_expected.to respond_to :name }
    it { is_expected.to respond_to :balance }
    it { is_expected.to respond_to :creation }
  end

  describe "#validations" do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_numericality_of :balance }
    it { is_expected.to validate_presence_of :balance }
    it { is_expected.to validate_presence_of :creation }
  end
end
