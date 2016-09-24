# frozen_string_literal: true
FactoryGirl.define do
  factory :sparkpost_response, class: Hash do
    type { "delivery" }
    timestamp { Time.current }
    subject  { "Example Subject" }
    rcpt_to  { "john@example.com" }
    msg_from { "system@example.com" }
    routing_domain { "example.com" }

    trait :bounce do
      type { "bounce" }
      bounce_class { SparkpostResponse::MessageEvents::BOUNCE_CLASS[SparkpostResponse::MessageEvents::BOUNCE_CLASS.keys.sample][:code] }
      error_code { 544 }
    end

    trait :delivery do
      type { "delivery" }
    end

    initialize_with { attributes }
  end
end
