FactoryBot.define do
  factory :user do
    name  { Faker::Name.name }
    email { Faker::Internet.unique.email }
    age   { Faker::Number.between(from: 1, to: 99) }
  end
end
