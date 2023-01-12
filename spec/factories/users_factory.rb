# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:email) { |n| Faker::Internet.safe_email(name: "random_email_#{n}") }
    sequence(:password) { |n| "password" }
  end
end
