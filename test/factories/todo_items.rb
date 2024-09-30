FactoryBot.define do
  factory :todo_item do
    title { Faker::Commerce.product_name }
    completed { false }
    todo_list { nil }
    trait :with_todo_list do
      association :todo_list
    end
    trait :completed do
      completed { true }
    end
  end
end
