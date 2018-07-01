FactoryGirl.define do
    factory :contact_lens_value do
        name {FactoryGirl.generate(:contact_lens_value_name)}
        contact_lens_item
    end
end
