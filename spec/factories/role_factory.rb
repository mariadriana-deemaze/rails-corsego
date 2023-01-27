# frozen_string_literal: true

FactoryBot.define do
  factory :role do
    name { ["admin", "student", "teacher"].sample }
  end
end
