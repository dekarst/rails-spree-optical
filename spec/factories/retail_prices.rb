# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :retail_price do
    variant_id 1
    amount "9.99"
    currency "MyString"
  end
end
