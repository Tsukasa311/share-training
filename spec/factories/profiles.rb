FactoryBot.define do
  factory :profile do
    experience_id              { Faker::Number.between(from: 1, to: 8) }
    part_id                    { Faker::Number.between(from: 1, to: 8) } 
    frequency_id               { Faker::Number.between(from: 1, to: 4) }
    introduction               { Faker::Lorem.sentence }
  end
end
