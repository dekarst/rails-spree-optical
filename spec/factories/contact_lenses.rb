FactoryGirl.define do
    factory :contact_lens, parent: :product, class: 'ContactLens' do
        name {"Acuvue 1 Day 30 pack (#{rand(1000)})"}
        contact_lens_category
    end
end
