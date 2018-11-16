class V1::LegalPersonHeadsController < ApplicationController
  before_action :set_head, only: :create
  before_action :find_head, only: :update

  def create
    if @head.save
      render json: { status: :success }
    else
      render json: {
        status: :failure,
        messages: @head.errors.messages
      }
    end
  end

  def update
    if do_update
      render json: { status: :success }
    else
      render json: {
        status: :failure,
        messages: @head.errors.messages
      }
    end
  end

  private

  def do_update
    @head.account.update(account_params) &&
      @head.account.person.update(legal_person_params)
  end

  def find_head
    @head = Head.find(params[:id])
  end

  def set_account
    @account = Account.new(account_params)
  end

  def set_head
    set_account
    set_legal_person
    @account.person = @legal_person
    @head = Head.new(account: @account)
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
