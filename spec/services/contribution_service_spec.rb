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
    expect(
      ::ContributionService.call(params)
    ).to be_a_kind_of(String)
  end

  it 'increases balance' do
    expect do
      ::ContributionService.call(params)
    end.to change(head.account, :balance).by(30000)
  end
end
