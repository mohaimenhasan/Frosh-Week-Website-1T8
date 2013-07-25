FactoryGirl.define do

  factory :user do |u|
    u.email { Faker::Internet.email }
    u.discipline 'Engineering Science'
    u.emergency_name { Faker::Name.name }
    u.emergency_phone { Faker::PhoneNumber.phone_number }
    u.emergency_relationship { Faker::Lorem.word }
    u.emergency_email { Faker::Internet.email }
    u.first_name { Faker::Name.first_name }
    u.last_name { Faker::Name.last_name }
    u.residence { Faker::Lorem.word }
    u.shirt_size 'Medium'
    u.gender 'Male'
    u.bursary_requested false
    u.package_id 1
  end

end
