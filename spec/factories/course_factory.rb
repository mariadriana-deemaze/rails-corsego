# frozen_string_literal: true

FactoryBot.define do
  factory :course do
    association :user, factory: :user
    title { Faker::Book.title }
    description { Faker::Markdown.sandwich }
    short_description { Faker::Quote.famous_last_words }
    language { ["English", "Portuguese"].sample }
    level { ["Beginner", "Intermediate", "Advanced"].sample }
    price { (10..250).to_a.sample }
    image { Rack::Test::UploadedFile.new('./app/assets/images/Oprah-You-Get-A.jpeg', 'image/jpeg') }
  end
end
