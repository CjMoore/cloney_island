FactoryGirl.define do
  factory :project do
    sequence(:name) { |n| "#{Faker::Company.name} #{n}" }
    description { Faker::StarWars.wookie_sentence }
    total { Faker::Number.between(1, 100) }
    time { Faker::Time.between(DateTime.now - 1, DateTime.now) }
    image_url { Faker::Avatar.image }
  end
end
