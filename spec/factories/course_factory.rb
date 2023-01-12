# frozen_string_literal: true

FactoryBot.define do
  factory :course do
    sequence(:title) { Faker::Book.title }
    sequence(:short_description) { Faker::Quote.famous_last_words }
    sequence(:description) { Faker::Markdown.sandwich }
    sequence(:language) { ["English", "Portuguese"].sample }
    sequence(:level) { ["Beginner", "Intermediate", "Advanced"].sample }
    sequence(:price) { |n| (10..250).to_a.sample }
  end
end
