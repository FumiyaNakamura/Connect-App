FactoryBot.define do
  factory :user do
    name {"tatsuro"}
    sequence(:email) { |n| "tatsuro#{n}@example.com"}
    password {"password"}
    activated { true }
  end
  
  factory :unactivate_user, class: User do
    name { "yoshi" }
    email { "yoshi@example.com" }
    password {"password"}
  end
  
  factory :activate_user, class: User do
    name { "yoshi" }
    email { "yoshi@example.com" }
    password {"password"}
    activated {true}
    reset_token {"k1CisE9s62fDZl_VWv4ADw"}
    reset_digest {"$2a$04$T2Mt/LmUaTV9MhhBrhL5b.G.dNhN9GNNGaGIobsYKgUm5dsnzso5q"}
    reset_sent_at {Time.zone.now}
  end
end