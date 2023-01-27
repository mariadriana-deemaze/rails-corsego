# frozen_string_literal: true

FactoryBot.define do
  factory :lesson do
    course
    title { Faker::Book.title }
    content {  Faker::Markdown.sandwich }
  end
end
