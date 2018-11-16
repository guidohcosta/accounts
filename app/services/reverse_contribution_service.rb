class ReverseContributionService
  attr_accessor :response, :contribution, :head_account

  def self.call(params)
    new(params).call
  end

  def call
    reverse
  end

  def initialize(params)
    @contribution = Contribution.find_by(code: params[:code])
    @head_account = @contribution.head
  end

  private

  def reverse
    ActiveRecord::Base.transaction do
      @head_account.account.update(balance: new_balance)
      @contribution.update(reversed: true)
    end
  end

  def new_balance
    @head_account.account.balance - @contribution.amount
  end
end
