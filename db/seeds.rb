def save?
  [true, false].sample
end

ActiveRecord::Base.transaction do
  puts "Destroying all users."
  User.destroy_all

  puts "Destroying all events."
  Event.destroy_all

  user_max = 1000
  user_max.times do |n|
    puts "Creating user (#{n + 1}/#{user_max})"
    user = User.new

    Faker::Config.locale = :en
    user.github_id = "#{Faker::Address.zip_code}#{n}"
    user.nickname = "#{Faker::Internet.slug(nil, '_')}_#{n}"

    user.twitter_name = user.nickname if save?
    user.facebook_name = user.nickname if save?
    user.qiita_name = user.nickname if save?

    user.image = Faker::Avatar.image
    user.email = Faker::Internet.email if save?
    user.introduction = Faker::Lorem.paragraph if save?
    user.github_url = "https://github.com/#{user.nickname}"
    user.blog = "http://#{user.nickname}.example.com" if save?
    user.birthday = Faker::Date.between(60.years.ago, 10.years.ago) if save?

    Faker::Config.locale = :ja
    user.name = Faker::Name.name if save?
    user.location = Faker::Address.city if save?

    user.save!
  end
end