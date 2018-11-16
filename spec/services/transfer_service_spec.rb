require 'rails_helper'

RSpec.describe TransferService do
  let(:params) do
    {
      from: from,
      to: to,
      amount: 2000
    }
  end

  let(:head) { create(:head, account: build(:account)) }
  let(:to) do
    create(:branch, parent: head, head: head, account: build(:account))
  end

  context 'when head is the origin' do
    let(:from) { head }

    it 'decreses origin account balance' do
      expect do
        ::TransferService.call(params)
      end.to change(from.account, :balance).by(-2000)
    end

    it 'increases destiny account balance' do
      expect do
        ::TransferService.call(params)
      end.to change(to.account, :balance).by(2000)
    end

    it 'creates a transfer' do
      expect do
        ::TransferService.call(params)
      end.to change(Transfer, :count).by(1)
    end
  end

  context 'when branch is the origin' do
    let(:from) do
      create(:branch, parent: head, head: head, account: build(:account))
    end

    it 'decreses origin account balance' do
      expect do
        ::TransferService.call(params)
      end.to change(from.account, :balance).by(-2000)
    end

    it 'increases destiny account balance' do
      expect do
        ::TransferService.call(params)
      end.to change(to.account, :balance).by(2000)
    end

    it 'creates a transfer' do
      expect do
        ::TransferService.call(params)
      end.to change(Transfer, :count).by(1)
    end
  end

  context 'when heads are different' do
    let(:other_head) { create(:head, account: build(:account)) }
    let(:from) do
      create(:branch, parent: other_head, head: other_head, account: build(:account))
    end

    it 'raises an error' do
      expect do
        ::TransferService.call(params)
      end.to raise_error ArgumentError
    end
  end
end
