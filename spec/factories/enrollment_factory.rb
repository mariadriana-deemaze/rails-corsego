# frozen_string_literal: true

FactoryBot.define do
  factory :enrollment do
    user
    course
    rating { (0..5).to_a.sample }
    review { Faker::Quote.famous_last_words }
    price { (10..250).to_a.sample }
  end
end
