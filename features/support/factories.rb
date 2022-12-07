FactoryBot.define do
    factory :owner, class: User do
        id {'1'}
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
        id {'696'}
        name {"Somtam"}
        address {"At AIT"}
        queuetime {"10"}
    end

    factory :wait_queue do
        restaurant_id {'696'}
        user_id {'1'}
        start_date {DateTime.now}
        end_date {DateTime.now}
        status {'waiting'}
    end

end