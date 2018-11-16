class V1::LegalPersonBranchsController < ApplicationController
  before_action :set_branch, only: :create
  before_action :find_branch, only: :update

  def create
    if @branch.save
      render json: { status: :success }
    else
      render json: {
        status: :failure,
        messages: @branch.errors.messages
      }
    end
  end

  def update
    if do_update
      render json: { status: :success }
    else
      render json: {
        status: :failure,
        messages: @branch.errors.messages
      }
    end
  end

  private

  def do_update
    @branch.account.update(account_params) &&
      @branch.account.person.update(legal_person_params)
  end

  def find_branch
    @branch = Branch.find(params[:id])
  end

  def set_account
    @account = Account.new(account_params)
  end

  def set_branch
    set_head
    set_account
    set_legal_person
    @account.person = @legal_person
    @branch = Branch.new(account: @account, head: @head, parent: @head)
  end

  def set_head
    @head = Head.find(params[:head_id])
  end

  def set_legal_person
    @legal_person = LegalPerson.new(legal_person_params)
  end

  def account_params
    params.require(:account)
          .permit(:name, :balance, :creation)
  end

  def legal_person_params
    params.require(:legal_person)
          .permit(:cnpj, :corporate_name, :trading_name)
  end
end
