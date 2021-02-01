FactoryBot.define do
  factory :post do
    text            {Faker::Lorem.words }
    part_id         {Faker::Number.between(from: 1, to: 8)}
    equipment_id    {Faker::Number.between(from: 1, to: 5)}
    place_id        {Faker::Number.between(from: 1, to: 2)}
   
    association :user
  end
end
