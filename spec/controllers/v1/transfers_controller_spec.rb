require 'rails_helper'

RSpec.describe V1::TransfersController, type: :controller do
  let(:head) { create(:head, account: build(:account)) }

  describe '#create' do
    before do
      allow(::TransferService).to receive(:call).and_return(mock_response)
    end

    context 'when successful' do
      let(:mock_response) do
        {
          status: :success
        }
      end

      it 'return success status and code' do
        expect(::TransferService).to receive(:call)
        post :create, params: { head_id: head.id, amount: 20000 }
        expect(response.status).to eq 200
        expect(response.body).to be_a_kind_of(String)
      end
    end

    context 'when unsuccessful' do
      let(:mock_response) do
        { status: :failure }
      end

      it 'return success status' do
        expect(::TransferService).to receive(:call)
        post :create, params: { head_id: head.id, amount: 20000 }
        expect(response.status).to eq 204
      end
    end
  end

  describe '#index' do
    let(:branch) do
      create(:branch, head: head, parent: head, account: build(:account))
    end
    let(:returned) { JSON.parse(response.body) }
    before do
      create_list(:transfer, 10, from: head, to: branch)
    end

    it 'return success status and code' do
      get :index
      expect(response.status).to eq 200
      expect(returned['body'].length).to eq 10
    end
  end
end
