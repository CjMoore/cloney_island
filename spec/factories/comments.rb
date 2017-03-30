FactoryGirl.define do
  factory :comment do
    project
    author Faker::Name.name
    content Faker::Lorem.sentence(2)
  end
end
