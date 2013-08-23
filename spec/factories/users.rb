FactoryGirl.define do

  factory :user do
    email { Faker::Internet.email }
    discipline 'Engineering Science'
    emergency_name { Faker::Name.name }
    emergency_phone { Faker::PhoneNumber.phone_number }
    emergency_relationship { Faker::Lorem.word }
    emergency_email { Faker::Internet.email }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    residence { Faker::Lorem.word }
    shirt_size 'Medium'
    gender 'Male'
    bursary_requested false
    package_id { Package.all.keep_if{|p| p.available?}.first.id }

    factory :bursary_requested_user do
      bursary_requested true
      bursary_engineering_motivation { Faker::Lorem.sentence }
      bursary_financial_reasoning { Faker::Lorem.sentence }
      bursary_osap false
    end

    factory :paying_user do
      cc_token Faker::Lorem.word
    end
  end

end
