class Account < ApplicationRecord
  validates :name, presence: true
  validates :balance,
    presence: true,
    numericality: true
  validates :creation, presence: true

  belongs_to :person, polymorphic: true, dependent: :destroy
  belongs_to :accountable, polymorphic: true
end
