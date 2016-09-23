# frozen_string_literal: true
FactoryGirl.define do
  factory :sparkpost_results, class: Hash do
    results { build_list(:sparkpost_response, 5) }

    trait :mixed do
      results { build_list(:sparkpost_response, 5, [:bounce, :delivery].sample) }
    end
    trait :bounce do
      results { build_list(:sparkpost_response, 5, :bounce) }
    end

    initialize_with { attributes }
  end
end
