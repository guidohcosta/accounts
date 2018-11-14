FactoryBot.define do
  factory :account do
    name { Faker::Bank.name }
    balance { Faker::Number.number(6) }
    creation { Faker::Date.backward(14) }
    association :person, factory: :legal_person
  end

  factory :natural_account, class: "Account" do
    name { Faker::Bank.name }
    balance { Faker::Number.number(6) }
    creation { Faker::Date.backward(14) }
    association :person, factory: :natural_person
  end
end
