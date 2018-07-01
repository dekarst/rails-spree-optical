require 'spec_helper'

describe ContactLens do
    let(:contact_lens) {FactoryGirl.create(:contact_lens)}

    it "has a valid factory" do
        expect(contact_lens).to be_valid
    end

    it "returns 'products' as singular_route_key" do
        expect(ContactLens.model_name.route_key).to eq 'products'
    end

    it "returns 'product' as route_key" do
        expect(ContactLens.model_name.singular_route_key).to eq 'product'
    end

    it "receives default shipping category" do
        default_shipping = Spree::ShippingCategory.find_by_name!('Default Shipping')

        expect(contact_lens.shipping_category).to eq default_shipping
    end

    it "receives tax category relative to Contact Lenses" do
        default_tax = Spree::TaxCategory.find_by_name!('Contact Lenses')

        expect(contact_lens.tax_category).to eq default_tax
    end

    it "receives category taxon relative to Contact Lenses" do
        taxon = Spree::Taxon.find_or_create_by(name: 'Contact Lenses', taxonomy_id: 1)

        expect(contact_lens.taxons).to eq [taxon]
    end

    it "ever has items on stock" do
        expect(contact_lens.total_on_hand).to eq Float::INFINITY
    end
end
