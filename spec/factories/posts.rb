FactoryBot.define do
  factory :post do
    title {"テスト"}
    sequence(:content) { |n| "テスト#{n}"}
    user_id { 1 }
  end
end