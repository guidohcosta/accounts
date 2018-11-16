class ContributionService
  attr_accessor :account, :amount, :response, :contribution

  def self.call(params)
    new(params).call
  end

  def call
    contribute
    respond
  end

  def initialize(params)
    @account = params[:account]
    @amount = params[:amount]
  end

  private

  def respond
    {
      status: status,
      body: @contribution.code
    }
  end

  def status
    @contribution.valid? ? :success : :failure
  end

  def contribute
    ActiveRecord::Base.transaction do
      @account.account.balance += @amount
      create_contribution
      @account.save
    end
  end

  def create_contribution
    @contribution = Contribution.create(
      head: @account,
      amount: @amount,
      reversed: false
    )
  end
end
