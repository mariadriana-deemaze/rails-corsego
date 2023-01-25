# frozen_string_literal: true

FactoryBot.define do
  factory :enrollment do
    user
    course
    sequence(:rating) { (0..5).to_a.sample }
    sequence(:review) { Faker::Quote.famous_last_words }
    sequence(:price) { (10..250).to_a.sample }
  end
end
