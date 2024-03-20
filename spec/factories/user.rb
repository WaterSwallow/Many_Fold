FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    username { Faker::Internet.username specifier: 3, separators: [] }
    password { Faker::Internet.password }

    factory :admin do
      after(:create) { |a| a.add_role :administrator }
    end
  end
end
