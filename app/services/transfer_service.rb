class TransferService
  attr_accessor :response, :from, :to, :amount

  def self.call(params)
    new(params).call
  end

  def call
    return response unless valid_tree?
    transfer
    response
  end

  def initialize(params)
    @from = params[:from]
    @to = params[:to]
    @amount = params[:amount]
  end

  private

  def response
    {
      status: status
    }
  end

  def status
    valid_tree? ? :success : :failure
  end

  def transfer
    ActiveRecord::Base.transaction do
      @from.account.balance -= @amount
      @to.account.balance += @amount
      create_transfer
      @from.save
      @to.save
    end
  end

  def valid_tree?
    @from.head_id == @to.head_id
  end

  def create_transfer
    Transfer.create(
      from: @from,
      to: @to,
      amount: @amount,
      reversed: false
    )
  end
end
