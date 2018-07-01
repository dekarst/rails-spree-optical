require 'spec_helper'

describe Spree::Stock::Packer do
    let(:order) {Spree::Order.create}
    let(:contact_lens_1) {FactoryGirl.create(:contact_lens)}
    let(:contact_lens_2) {FactoryGirl.create(:contact_lens)}
    let(:product) {FactoryGirl.create(:product)}

    context "#default_package" do
        before :each do
            @stock_location = Spree::StockLocation.first
            product.master.stock_items.first.stock_movements.create!(quantity: 10)

            @populator = Spree::OrderPopulator.new(order, 'USD')
            @populator.populate(variants: {product.master.id => 1})
        end

        it "continues with normal behaviour for non Contact Lens line item" do
            packer = Spree::Stock::Packer.new(@stock_location, order, Rails.application.config.spree.stock_splitters)

            expect(packer.packages.size).to eq 1
            expect(packer.packages.first.contents).to eq [Spree::Stock::Package::ContentItem.new(product.master, 1, :on_hand)]
        end

        it "builds a generic package for each line item that belongs to Contact Lens" do
            item_1 = FactoryGirl.create(:contact_lens_item, contact_lens_category: contact_lens_1.contact_lens_category)
            item_2 = FactoryGirl.create(:contact_lens_item, contact_lens_category: contact_lens_2.contact_lens_category)
            value_1 = FactoryGirl.create(:contact_lens_value, contact_lens_item: item_1)
            value_2 = FactoryGirl.create(:contact_lens_value, contact_lens_item: item_2)

            @populator.populate({
                variants: {product.master.id => 1, contact_lens_1.master.id => 1},
                contact_lens_options: {
                    left: {values: [value_1.id], quantity: 10},
                    right: {values: [value_1.id], quantity: 20},
                },
            })
            @populator.populate({
                variants: {contact_lens_2.master.id => 1},
                contact_lens_options: {
                    left: {values: [value_2.id], quantity: 100},
                    right: {values: [value_2.id], quantity: 200},
                },
            })

            packer = Spree::Stock::Packer.new(@stock_location, order, Rails.application.config.spree.stock_splitters)

            expect(order.line_items.size).to eq 5

            expect(packer.packages.size).to eq 1
            expect(packer.packages.first.contents).to eq [
                Spree::Stock::Package::ContentItem.new(product.master, 2, :on_hand),
                Spree::Stock::Package::ContentItem.new(contact_lens_1.master, 10, :on_hand),
                Spree::Stock::Package::ContentItem.new(contact_lens_1.master, 20, :on_hand),
                Spree::Stock::Package::ContentItem.new(contact_lens_2.master, 100, :on_hand),
                Spree::Stock::Package::ContentItem.new(contact_lens_2.master, 200, :on_hand),
            ]
        end
    end
end
