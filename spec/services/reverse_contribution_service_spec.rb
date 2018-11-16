require 'rails_helper'

RSpec.describe ReverseContributionService do
  let(:params) do
    {
      code: contribution.code
    }
  end
  let(:head) { create(:head, account: build(:account)) }
  let(:contribution) do
    create(:contribution, head: head, amount: 2000, reversed: false)
  end

  context 'when code is right' do
    let(:changed_contribution) do
      Contribution.find_by(code: contribution.code)
    end
    let(:changed_head) do
      Head.find(head.id)
    end

    it 'restores head account balance' do
      expected_balance = head.account.balance - 2000
      ::ReverseContributionService.call(params)
      expect(changed_head.account.balance).to eq expected_balance
    end

    it 'changes contribution to reversed' do
      ::ReverseContributionService.call(params)
      expect(changed_contribution.reversed).to be true
    end
  end
end
