FactoryBot.define do
  factory :user do
    nickname                   { Faker::Name.name }
    experience_id              { Faker::Number.between(from: 1, to: 8) }
    introduction               { Faker::Lorem.sentence }
    email                      { Faker::Internet.free_email }
    password                   { '1a' + Faker::Internet.password(min_length: 6) }
    password_confirmation      { password }
  end
end
