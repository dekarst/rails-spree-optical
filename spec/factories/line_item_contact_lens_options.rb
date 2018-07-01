FactoryGirl.define do
    factory :line_item_contact_lens_option do
        line_item {FactoryGirl.create(:line_item_with_contact_lens)}

        after :build do |line_item_contact_lens_option|
            if line_item_contact_lens_option.contact_lens_value.nil?
                if line_item_contact_lens_option.line_item.variant.product.is_a?(ContactLens)
                    item = FactoryGirl.create(:contact_lens_item, contact_lens_category: line_item_contact_lens_option.line_item.variant.product.contact_lens_category)

                    line_item_contact_lens_option.contact_lens_value = FactoryGirl.create(:contact_lens_value, contact_lens_item: item)
                else
                    line_item_contact_lens_option.contact_lens_value = FactoryGirl.create(:contact_lens_value)
                end
            end
        end
    end
end
