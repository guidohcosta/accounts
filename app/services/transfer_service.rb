class TransferService
  attr_accessor :response, :from, :to, :balance

  def self.call(params)
    new(params).call
  end

  def call
    unless valid_tree?
      raise ArgumentError, 'Accounts should belong to the same tree'
    end
    transfer
  end

  def initialize(params)
    @from = params[:from]
    @to = params[:to]
    @balance = params[:balance]
  end

  private

  def transfer
    ActiveRecord::Base.transaction do
      @from.account.balance -= @balance
      @to.account.balance += @balance

      @from.save
      @to.save
    end
  end

  def valid_tree?
    @from.head_id == @to.head_id
  end
end
