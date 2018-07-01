require 'spec_helper'

describe Spree::Stock::Quantifier do
    context "total_on_hand" do
        it "returns INFINITY when the variant belongs to a Contact Lens" do
            contact_lens = FactoryGirl.create(:contact_lens)
            variant = contact_lens.master.id

            expect(Spree::Stock::Quantifier.new(variant).total_on_hand).to eq Float::INFINITY
        end

        it "returns the right value for variants that non belongs to a Contact Lens" do
            Spree::StockLocation.create!(name: 'Default Stock Location')

            product_1 = FactoryGirl.create(:product)
            product_2 = FactoryGirl.create(:product)

            variant_1 = product_1.master.id
            variant_2 = product_2.master.id

            product_2.master.stock_items.first.stock_movements.create!(quantity: 10)

            expect(Spree::Stock::Quantifier.new(variant_1).total_on_hand).to eq 0
            expect(Spree::Stock::Quantifier.new(variant_2).total_on_hand).to eq 10
        end
    end
end
