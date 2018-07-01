# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :prescription_limitation do
    limitationable_id 1
    limitationable_type "MyString"
    prescription_item_id 1
    min 1.5
    max 1.5
  end
end
