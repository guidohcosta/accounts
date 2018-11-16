require 'rails_helper'

RSpec.describe ContributionService do
  let(:head) { create(:head, account: build(:account)) }
  let(:params) do
    {
      account: head,
      amount: 30000
    }
  end

  it 'returns the contribution code' do
    response = ::ContributionService.call(params)
    expect(response[:status]).to eq :success
    expect(response[:body]).to be_a_kind_of(String)
  end

  it 'increases balance' do
    expect do
      ::ContributionService.call(params)
    end.to change(head.account, :balance).by(30000)
  end

  it 'creates a contribution' do
    expect do
      ::ContributionService.call(params)
    end.to change(Contribution, :count).by(1)
  end
end
