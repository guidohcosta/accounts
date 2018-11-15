class Branch < ApplicationRecord
  validates :head, presence: true
  validates :parent, presence: true

  belongs_to :head
  belongs_to :parent, polymorphic: true
  has_one :branch, as: :parent, dependent: :destroy
  has_one :account, as: :accountable, dependent: :destroy
end
