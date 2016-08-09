def validatable_phone_number
  # Can't just use Faker.Phone Number because some of the formats it
  # accepts are not parseable by GlobalPhone, and it area codes are
  # also validated
  Faker::Base.numerify('904-###-####')
end

FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password "password"
    password_confirmation "password"
  end

  # Telesoci: 
  # Only phone is required
  factory :telesoci do
    phone { validatable_phone_number }
  end

  factory :telesoci_with_name, class: Telesoci do
    # Can't use Faker.Phone Number because some of the formats Faker
    # accepts are not parseable by GlobalPhone
    phone      { validatable_phone_number }
    first_name { Faker::Name.first_name }
    last_name  { Faker::Name.last_name }
  end

  factory :telesoci_with_url, class: Telesoci  do
    phone { validatable_phone_number }
    url   { Faker::Internet.url }
  end
end
