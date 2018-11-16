class ReverseTransferService
  attr_accessor :response, :transfer, :from, :to

  def self.call(params)
    new(params).call
  end

  def call
    reverse
  end

  def initialize(params)
    @transfer = Transfer.find(params[:id])
    @from = @transfer.from
    @to = @transfer.to
  end

  private

  def reverse
    ActiveRecord::Base.transaction do
      @from.account.update(balance: new_from_balance)
      @to.account.update(balance: new_to_balance)
      @transfer.update(reversed: true)
    end
  end

  def new_from_balance
    @from.account.balance + @transfer.amount
  end

  def new_to_balance
    @to.account.balance - @transfer.amount
  end
end
