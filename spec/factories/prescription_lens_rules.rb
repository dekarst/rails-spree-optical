# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :prescription_lens_rule do
    contact_lens_id 1
    operation "MyString"
    value "MyString"
  end
end
