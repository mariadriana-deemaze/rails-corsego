# frozen_string_literal: true

FactoryBot.define do
  factory :enrollment do
    sequence(:rating) { (0..5).to_a.sample }
    sequence(:review) { Faker::Quote.famous_last_words }
    sequence(:price) { (10..250).to_a.sample }
    user
    course { FactoryBot.build(:course)}
    association :user_id, factory: :user
  end
end
