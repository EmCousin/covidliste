FactoryBot.define do
  factory :article do
    association :author, factory: :user
    title { Faker::Lorem.word }
    slug { Faker::Internet.slug }
    meta_title { Faker::Lorem.word }
    description { Faker::Lorem.paragraph }
    meta_description { Faker::Lorem.paragraph }
    meta_keywords { Faker::Lorem.word }
    meta_robots { "noindex,nofollow" }
    content { Faker::Lorem.paragraph }

    trait :published do
      published_at { Time.current }
    end
  end
end
