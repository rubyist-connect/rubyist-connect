# Omniauth から返ってきた request.env['omniauth.auth'] を Hash で返す
FactoryBot.define do
  factory :omniauth_hash, class: Hash do
    provider { 'github' }
    uid { Random.rand(1 .. 100000).to_s }
    info { {
      'nickname' => Faker::Internet.user_name,
      'email' => Faker::Internet.email,
      'name' => Faker::Name.name,
      'image' => Faker::Internet.url,
      'urls' => {
        'GitHub' => Faker::Internet.url,
        'Blog' => Faker::Internet.url
      }
    } }
    credentials { {
      'token' => Faker::Internet.password,
      'expires' => false
    } }

    initialize_with { attributes }
  end
end
