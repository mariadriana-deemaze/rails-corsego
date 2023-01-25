# frozen_string_literal: true

FactoryBot.define do
  factory :lesson do
    course
    sequence(:title) { Faker::Book.title }
    sequence(:content) { Faker::Quote.famous_last_words }
  end
end
