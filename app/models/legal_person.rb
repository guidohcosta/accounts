class LegalPerson < ApplicationRecord
  validates :cnpj, presence: true
  validates :corporate_name, presence: true
  validates :trading_name, presence: true

  has_one :account, as: :person, dependent: :destroy
end
