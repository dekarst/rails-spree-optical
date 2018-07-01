FactoryGirl.define do
    factory :contact_lens_item do
        name {"Power (#{rand(1000)})"}
        contact_lens_category
    end
end
