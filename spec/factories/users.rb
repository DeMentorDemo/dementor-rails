FactoryBot.define do
  factory :user do
    email {Faker::Internet.email}
    password {'1111qwer'}
    password_confirmation {'1111qwer'}
  end
end