FactoryBot.define do
  factory :user do
    name {"tatsuro"}
    sequence(:email) { |n| "tatsuro#{n}@example.com"}
    password {"password"}
  end
end
