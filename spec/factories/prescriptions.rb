# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :prescription do
    user_id 1
    line_item_id 1
  end
end
