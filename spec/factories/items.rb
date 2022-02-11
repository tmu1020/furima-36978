FactoryBot.define do
  factory :item do
    association :user

    item_name        {'test-item'}
    description      {'test'}
    category_id      { 1 }
    condition_id     { 1 }
    shipping_cost_id { 1 }
    prefecture_id    { 1 }
    shipping_day_id  { 1 }
    price            { 300 }

    after(:build) do |item|
      item.image.attach(io: File.open('app/assets/images/test_image.png'), filename: 'test_image.png')
    end
  end
end