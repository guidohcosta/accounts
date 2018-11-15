FactoryBot.define do
  factory :legal_person do
    cnpj { Faker::Number.number(14) }
    corporate_name { Faker::Company.name }
    trading_name { Faker::SiliconValley.company }
  end
end
