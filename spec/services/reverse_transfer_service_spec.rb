require 'rails_helper'

RSpec.describe ReverseTransferService do
  let(:params) do
    {
      id: transfer.id
    }
  end
  let(:head) { create(:head, account: build(:account)) }
  let(:to) do
    create(:branch, parent: head, head: head, account: build(:account))
  end
  let(:transfer) do
    create(:transfer, from: head, to: to, amount: 2000, reversed: false)
  end

  context 'when code is right' do
    let(:changed_transfer) { Transfer.find(transfer.id) }
    let(:changed_head) { Head.find(head.id) }
    let(:changed_to) { Branch.find(to.id) }

    it 'rollback transfer and update status' do
      expected_head_balance = head.account.balance + 2000
      expected_branch_balance = to.account.balance - 2000
      ::ReverseTransferService.call(params)

      expect(changed_head.account.balance).to eq expected_head_balance
      expect(changed_to.account.balance).to eq expected_branch_balance
      expect(changed_transfer.reversed).to be true
    end
  end
end
