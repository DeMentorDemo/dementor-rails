# frozen_string_literal: true

FactoryBot.define do
  factory :message do
    user_id { 1 }
    chat_id { 1 }
  end
end
