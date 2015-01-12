FactoryGirl.define do
  factory :user do
    github_id { Faker::Address.zip_code } # idの代用
    nickname { Faker::Internet.slug(nil, '_') }

    name { Faker::Name.name }
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

    factory :inactive_user do
      name nil
      image nil
      email nil
      introduction nil
      twitter_name nil
      github_url nil
      facebook_name nil
      location nil
      blog nil
      birthday nil
      qiita_name nil
    end
  end
end
