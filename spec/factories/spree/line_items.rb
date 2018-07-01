FactoryGirl.define do
    factory :line_item, class: 'Spree::LineItem' do
        order {Spree::Order.create}
        variant {FactoryGirl.create(:product).master}
    end

    factory :line_item_with_contact_lens, parent: :line_item, class: 'Spree::LineItem' do
        variant {FactoryGirl.create(:contact_lens).master}
        eye 'left'
    end
end
