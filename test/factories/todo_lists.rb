FactoryBot.define do
  factory :todo_list do
    name { Faker::Lorem.sentence }
    trait :with_todo_items do
      after(:create) do |todo_list|
        create_list(:todo_item, 3, todo_list:)
      end
    end
  end
end
