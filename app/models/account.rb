class Account < ApplicationRecord
  validates :name, presence: true
  validates :balance,
    presence: true,
    numericality: true
  validates :creation, presence: true
end
