class Head < ApplicationRecord
  has_many :branches, as: :parent, dependent: :destroy
  has_many :contributions
  has_many :transfers, as: :from
  has_one :account, as: :accountable, dependent: :destroy

  def head_id
    id
  end
end
