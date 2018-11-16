require 'rails_helper'

RSpec.describe V1::ContributionsController, type: :controller do
  let(:head) { create(:head, account: build(:account)) }

  describe '#fetch_api' do
    before do
      allow(::ContributionService).to receive(:call).and_return(mock_response)
    end

    context 'when successful' do
      let(:mock_response) do
        {
          status: :success,
          body: 'TOKEN123'
        }
      end

      it 'return success status and code' do
        expect(::ContributionService).to receive(:call)
        get :fetch_api, params: { head_id: head.id, amount: 20000 }
        expect(response.status).to eq 200
        expect(response.body).to be_a_kind_of(String)
      end
    end

    context 'when unsuccessful' do
      let(:mock_response) do
        { status: :failure }
      end

      it 'return success status' do
        expect(::ContributionService).to receive(:call)
        get :fetch_api, params: { head_id: head.id, amount: 20000 }
        expect(response.status).to eq 204
      end
    end
  end
end
