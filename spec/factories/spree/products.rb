FactoryGirl.define do
    factory :product, class: 'Spree::Product' do
        name {"Test Product ##{rand(1000)}"}
        price 19.99
        available_on Time.zone.now

        after :build do |product|
            product.shipping_category ||= Spree::ShippingCategory.find_by_name!('Default Shipping')
        end
    end
end
