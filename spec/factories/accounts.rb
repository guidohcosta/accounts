FactoryBot.define do
  factory :account do
    name { Faker::Bank.name }
    balance { Faker::Number.number(6) }
    creation { Faker::Date.backward(14) }
  end
end
