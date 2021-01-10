FactoryBot.define do
  factory :partnership do
    title { Faker::Lorem.word }
    description { Faker::Lorem.paragraph(2) }
  end

  factory :user do
    email { "#{Faker::Internet.user_name}@customdomain.com" }
    name { Faker::Name.first_name }
    password { "password" }
    token { SecureRandom.hex }
    after :create do |s|
        s.partnerships << FactoryBot.create(:partnership)
    end
  end
end