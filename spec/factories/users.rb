FactoryBot.define do
  factory :user do
    sequence(:github_id) {|n| "#{Faker::Address.zip_code}#{n}" }
    sequence(:nickname) {|n| "#{Faker::Internet.slug(nil, '_')}_#{n}" }

    sequence(:name) {|n| "#{Faker::Name.name}-#{n}" }
    image { Faker::Avatar.image }
    email { Faker::Internet.email }
    introduction { Faker::Lorem.paragraph }
    twitter_name { Faker::Internet.slug }
    github_url { "https://github.com/#{Faker::Internet.slug}" }
    facebook_name { Faker::Internet.slug }
    location { Faker::Address.city }
    blog { Faker::Internet.url }
    birthday { Faker::Date.between(60.years.ago, 10.years.ago) }
    qiita_name { Faker::Internet.slug }

    trait :with_notification_enabled do
      new_user_notification_enabled { true }
    end

    trait :with_inactive_fields do
      name { nil }
      email { nil }
      introduction { nil }
      twitter_name { nil }
      github_url { nil }
      facebook_name { nil }
      location { nil }
      blog { nil }
      birthday { nil }
      qiita_name { nil }
    end
  end
end
