class NaturalPerson < ApplicationRecord
  validates :cpf, presence: true
  validates :fullname, presence: true
  validates :birthdate, presence: true

  has_one :account, as: :person, dependent: :destroy
end
