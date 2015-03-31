FactoryGirl.define do
  factory :contact do
    first_name { Faker::Name.first_name          }
    last_name  { Faker::Name.last_name           }
    number     { Faker::PhoneNumber.phone_number }
  end
end
