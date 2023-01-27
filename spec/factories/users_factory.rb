# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:email) { |n| Faker::Internet.safe_email(name: "random_email_#{n}") }
    password { "password" }
    after(:create) {user.add_role(:student)}

    factory :teacher do
        after(:create) { |user| user.add_role(:teacher)}
    end

    factory :admin do
        after(:create) { |user| user.add_role(:admin)}
    end
  end
end
