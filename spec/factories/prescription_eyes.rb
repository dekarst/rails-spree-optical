# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :prescription_eye do
    name "MyString"
    prescription_id 1
    contact_lens_category_id 1
  end
end
