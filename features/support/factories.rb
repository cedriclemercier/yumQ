FactoryBot.define do
    factory :owner, class: User do
        email { "owner@ait.asia" }
        username {"owner"}
        first_name {"test"}
        last_name {"user"}
        phone_number {"1838219999"}
        password { "password" }
        password_confirmation { "password" }
    end
        
    factory :user do
    email { "testuser@ait.asia" }
    username {"testuser"}
    first_name {"test"}
    last_name {"user"}
    phone_number {"0838219999"}
    password { "password" }
    password_confirmation { "password" }
    end

    factory :restaurant do
        association :user
        id {'1'}
        name {"Somtam"}
        address {"At AIT"}
    end

end