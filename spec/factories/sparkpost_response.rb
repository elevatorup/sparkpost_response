# frozen_string_literal: true
FactoryGirl.define do
  factory :sparkpost_results, class: Hash do
    total_count { 5 }
    transmission_id { "1234" }
    subject { "Welcome to Roommates.com" }
    results do
      build_list(:sparkpost_response,
                 total_count,
                 transmission_id: transmission_id,
                 subject: subject)
    end

    trait :mixed do
      results do
        build_list(:sparkpost_response,
                   total_count,
                   [:bounce, :delivery].sample,
                   transmission_id: transmission_id,
                   subject: subject)
      end
    end
    trait :bounce do
      results do
        build_list(:sparkpost_response,
                   total_count,
                   :bounce,
                   transmission_id: transmission_id,
                   subject: subject)
      end
    end

    initialize_with { attributes }
  end

  factory :sparkpost_response, class: Hash do
    type { "delivery" }
    timestamp { DateTime.now }
    subject  { "Welcome to Roommates.com" }
    rcpt_to  { "john@example.com" }
    msg_from { "system@example.com" }
    transmission_id { "1234" }

    trait :bounce do
      type { "bounce" }
      bounce_class { ::SparkpostResponse::MessageEvents::BOUNCE_CLASS[::SparkpostResponse::MessageEvents::BOUNCE_CLASS.keys.sample][:code] }
      error_code { 544 }
    end

    trait :delivery do
      type { "delivery" }
    end

    initialize_with { attributes }
  end
end
