# frozen_string_literal: true

FactoryBot.define do
  factory :course do
    user
    sequence(:title) { Faker::Book.title }
    sequence(:description) { Faker::Markdown.sandwich }
    sequence(:short_description) { Faker::Quote.famous_last_words }
    sequence(:language) { ["English", "Portuguese"].sample }
    sequence(:level) { ["Beginner", "Intermediate", "Advanced"].sample }
    sequence(:price) { |n| (10..250).to_a.sample }
    sequence(:image) {  Rack::Test::UploadedFile.new('./app/assets/images/Oprah-You-Get-A.jpeg', 'image/jpeg') }
  end
end
