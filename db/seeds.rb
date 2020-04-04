User.create!(name:  "Example User",
             email: "example@example.com",
             password:              "foobar",
             password_confirmation: "foobar")

100.times do |n|
  name = Faker::Pokemon.name
  email = Faker::Internet.email
  password = "password"
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password,
               )
end

# users = User.order(:created_at).take(6)
# 50.times do
#   title = Faker::Lorem.sentence(5)
#   content = Faker::Lorem.sentence(5)
#   users.each { |user| user.posts.create!(title: title, content: content) }
# end