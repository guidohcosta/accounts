class Branch < ApplicationRecord
  validates :head, presence: true
  validates :parent, presence: true

  belongs_to :head
  belongs_to :parent, polymorphic: true
  has_one :branch, as: :parent, dependent: :destroy
  has_one :account, as: :accountable, dependent: :destroy
  has_many :transfers, as: :from
  has_many :received_transfers,
    as: :to, class_name: 'Transfer', foreign_key: :to
end
