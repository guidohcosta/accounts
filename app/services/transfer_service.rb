class TransferService
  attr_accessor :response, :from, :to, :amount

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
    @amount = params[:amount]
  end

  private

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
