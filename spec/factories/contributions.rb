FactoryBot.define do
  factory :contribution do
    head
    amount { Faker::Number.number(6) }
    reversed false
  end
end
