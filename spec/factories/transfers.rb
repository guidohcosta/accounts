FactoryBot.define do
  factory :transfer do
    amount { Faker::Number.number(6) }
    reversed { false }
  end
end
