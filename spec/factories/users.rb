FactoryGirl.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    password { Faker::Team.state }
    email { Faker::Internet.email }
    phone { Faker::PhoneNumber.cell_phone }
    username { Faker::Hacker.noun }
  end
end
