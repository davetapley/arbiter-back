FactoryGirl.define do
  factory :translation do
    sequence(:token) { |n| "token_#{ n }" }
    sequence(:priority) { |n| n }
    target 'www.google.com'

    trait :always do
      rule({ type: 'Always' })
    end

    trait :period do
      rule do
        { type: 'Period',
          first: 1.hour.from_now.iso8601,
          last: 2.hours.from_now.iso8601 }
      end
    end

  end
end
