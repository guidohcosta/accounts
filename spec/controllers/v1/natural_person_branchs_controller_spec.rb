require 'rails_helper'

RSpec.describe V1::NaturalPersonBranchsController, type: :controller do
  let(:response) { JSON.parse(subject.body) }
  let!(:head) { create(:head, account: build(:account)) }
  describe '#create' do
    let(:account_params) { attributes_for :account }
    let(:natural_person_params) { attributes_for :natural_person }

    subject(:do_create) do
      post :create,
        params: {
          head_id: head.id,
          account: account_params,
          natural_person: natural_person_params
        }
    end

    context 'when succesful' do
      it { expect { do_create }.to change(Branch, :count).by 1 }
      it { expect { do_create }.to change(Account, :count).by 1 }
      it { expect { do_create }.to change(NaturalPerson, :count).by 1 }
      it { expect(response).to have_key 'status' }
      it { expect(response['status']).to eq 'success' }
    end

    context 'when unsuccessful' do
      let(:head_double) { double(:head) }
      before do
        allow(head_double).to receive(:save).and_return false
        Branch.any_instance.stub(:save).and_return(false)
      end

      it { expect { do_create }.to change(Branch, :count).by 0 }
      it { expect { do_create }.to change(Account, :count).by 0 }
      it { expect { do_create }.to change(NaturalPerson, :count).by 0 }
      it { expect(response['status']).to eq 'failure' }
      it { expect(response).to have_key 'messages' }
    end
  end

  describe '#update' do
    subject(:do_update) do
      patch :update,
        params: {
          id: branch.id,
          account: { name: 'New name' },
          natural_person: { fullname: 'New person name' }
        }
    end
    let(:branch) do
      create(:branch, head: head, parent: head,  account: build(:natural_account))
    end
    let(:updated_branch) { Branch.find(branch.id) }

    context 'when successful' do
      it 'changes attributes' do
        do_update
        expect(updated_branch.account.name).to eq 'New name'
        expect(updated_branch.account.person.fullname).to eq 'New person name'
      end

      it { expect(response['status']).to eq 'success' }
    end

    context 'when unsuccessful' do
      before { Account.any_instance.stub(:update).and_return(false) }

      it 'does not change attributes' do
        do_update
        expect(updated_branch.account.name).not_to eq 'New name'
        expect(updated_branch.account.person.fullname).not_to eq 'New person name'
      end

      it { expect(response['status']).to eq 'failure' }
    end
  end
end
