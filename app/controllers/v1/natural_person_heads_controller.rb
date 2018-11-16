class V1::NaturalPersonHeadsController < ApplicationController
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
      @head.account.person.update(natural_person_params)
  end

  def find_head
    @head = Head.find(params[:id])
  end

  def set_account
    @account = Account.new(account_params)
  end

  def set_head
    set_account
    set_natural_person
    @account.person = @natural_person
    @head = Head.new(account: @account)
  end

  def set_natural_person
    @natural_person = NaturalPerson.new(natural_person_params)
  end

  def account_params
    params.require(:account)
          .permit(:name, :balance, :creation)
  end

  def natural_person_params
    params.require(:natural_person)
          .permit(:cpf, :fullname, :birthdate)
  end
end
