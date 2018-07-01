require 'spec_helper'

describe Spree::OrderPopulator do
    before :each do
        @order = Spree::Order.create
        product = FactoryGirl.create(:product)
        contact_lens = FactoryGirl.create(:contact_lens)

        product.master.stock_items.first.update_attribute(:count_on_hand, 1)

        category = contact_lens.contact_lens_category
        item_1 = FactoryGirl.create(:contact_lens_item, contact_lens_category: category)
        item_2 = FactoryGirl.create(:contact_lens_item, contact_lens_category: category)
        @value_1 = FactoryGirl.create(:contact_lens_value, contact_lens_item: item_1)
        @value_2 = FactoryGirl.create(:contact_lens_value, contact_lens_item: item_2)

        @contact_lens_options = {
            left: {values: [@value_1.id, @value_2.id], quantity: 1},
            right: {values: [@value_1.id, @value_2.id], quantity: 1},
        }

        @params = {variants: {'1' => '1'}}
        @params_for_contact_lens = {variants: {'2' => '1'}, contact_lens_options: @contact_lens_options}

        @populator = Spree::OrderPopulator.new(@order, 'USD')
    end

    it "keeps normal behaviour for adding items to cart" do
        @populator.populate(@params)
        @order.reload

        expect(@order.line_items.size).to eq 1
    end

    it "adds two line items to order" do
        @populator.populate(@params_for_contact_lens)
        @order.reload

        expect(@order.line_items.size).to eq 2
    end

    it "add four line items to order when pass two variants" do
        new_contact_lens = FactoryGirl.create(:contact_lens)
        @params_for_contact_lens.delete(:variants)

        @populator.populate(@params_for_contact_lens.merge(variants: {'2' => 1, new_contact_lens.master.id => 1}))
        @order.reload

        expect(@order.line_items.size).to eq 4
    end

    it "add two line items to order when pass two variants but only for left eye" do
        new_contact_lens = FactoryGirl.create(:contact_lens)
        @params_for_contact_lens.delete(:variants)
        @contact_lens_options = {
            left: {values: [@value_1.id, @value_2.id], quantity: 1},
            right: {quantity: 0},
        }

        @populator.populate({variants: {'2' => 1, new_contact_lens.master.id => 1}, contact_lens_options: @contact_lens_options})
        @order.reload

        expect(@order.line_items.size).to eq 2
    end

    context "adding contact lens options" do
        it "adds two line items to order when params have products and quantity" do
            @params_for_contact_lens.delete(:variants)
            @populator.populate(@params_for_contact_lens.merge({products: {'2' => '2'}, quantity: 1}))
            @order.reload

            expect(@order.line_items.size).to eq 2
        end

        it "adds contact lens options to each line when populating the cart" do
            @populator.populate(@params_for_contact_lens)
            @order.reload

            @order.line_items.each do |line_item|
                expect(line_item.contact_lens_options.size).to eq 2
            end
        end
    end
end
