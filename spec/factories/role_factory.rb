# frozen_string_literal: true

FactoryBot.define do
  factory :role do
    sequence(:name) { ["admin", "student", "teacher"].sample }
  end
end
