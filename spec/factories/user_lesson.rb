# frozen_string_literal: true

FactoryBot.define do
    factory :user_lesson do
      user
      lesson
      impressions { 0 }
    end
  end
  