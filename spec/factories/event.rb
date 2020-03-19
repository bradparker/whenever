# frozen_string_literal: true

FactoryBot.define do
  factory :event do
    duration { 60 }
    sequence :title do |n|
      "Event #{n}"
    end
    starts_at { Time.utc }
  end
end
