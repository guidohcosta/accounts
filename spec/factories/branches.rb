FactoryBot.define do
  factory :branch do
    parent_id { 1 }
    parent_type { "MyString" }
    head { nil }
  end
end
