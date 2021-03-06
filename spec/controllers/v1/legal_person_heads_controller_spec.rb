require 'rails_helper'

RSpec.describe V1::LegalPersonHeadsController, type: :controller do
  let(:response) { JSON.parse(subject.body) }
  describe '#create' do
    let(:account_params) { attributes_for :account }
    let(:legal_person_params) { attributes_for :legal_person }

    subject(:do_create) do
      post :create,
        params: {
          account: account_params,
          legal_person: legal_person_params
        }
    end

    context 'when succesful' do
      it { expect { do_create }.to change(Head, :count).by 1 }
      it { expect { do_create }.to change(Account, :count).by 1 }
      it { expect { do_create }.to change(LegalPerson, :count).by 1 }
      it { expect(response).to have_key 'status' }
      it { expect(response['status']).to eq 'success' }
    end

    context 'when unsuccessful' do
      let(:head_double) { double(:head) }
      before do
        allow(head_double).to receive(:save).and_return false
        Head.any_instance.stub(:save).and_return(false)
      end

      it { expect { do_create }.to change(Head, :count).by 0 }
      it { expect { do_create }.to change(Account, :count).by 0 }
      it { expect { do_create }.to change(LegalPerson, :count).by 0 }
      it { expect(response['status']).to eq 'failure' }
      it { expect(response).to have_key 'messages' }
    end
  end

  describe '#update' do
    subject(:do_update) do
      patch :update,
        params: {
          id: head.id,
          account: { name: 'New name' },
          legal_person: { corporate_name: 'New corporate name' }
        }
    end
    let(:head) { create(:head, account: build(:account)) }
    let(:updated_head) { Head.find(head.id) }

    context 'when successful' do
      it 'changes attributes' do
        do_update
        expect(updated_head.account.name).to eq 'New name'
        expect(updated_head.account.person.corporate_name).to eq 'New corporate name'
      end

      it { expect(response['status']).to eq 'success' }
    end

    context 'when unsuccessful' do
      before { Account.any_instance.stub(:update).and_return(false) }

      it 'does not change attributes' do
        do_update
        expect(updated_head.account.name).not_to eq 'New name'
        expect(updated_head.account.person.corporate_name).not_to eq 'New corporate name'
      end

      it { expect(response['status']).to eq 'failure' }
    end
  end
end
