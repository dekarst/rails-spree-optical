FactoryGirl.define do
    sequence :email do |n|
        "user#{n}@example.com"
    end

    sequence :contact_lens_value_name do |n|
        "+#{n}.00"
    end
end
