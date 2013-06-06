namespace :db do
  desc "Fill database with dummy userse"
  task populate: :environment do
    User.create!(name: "Test User",
                email: "test@email.com",
                password: "password",
                password_confirmation: "password")
    99.times do |n|
      name = Faker::Name.name
      email = "sample-#{n+1}@email.com"
      password = "password"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
  end
end
