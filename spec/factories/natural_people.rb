FactoryBot.define do
  factory :natural_person do
    cpf { Faker::Number.number(11) }
    fullname { Faker::Name.name }
    birthdate { Faker::Date.between(18.years.ago, 30.years.ago) }
  end
end
