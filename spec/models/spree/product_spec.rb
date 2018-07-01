require 'spec_helper'

describe Spree::Product do
    let(:product) {FactoryGirl.create(:product)}

    before :each do
        @taxon_category = Spree::Taxon.find_or_create_by(name: 'Contact Lenses', taxonomy_id: 1)
        @taxon_brand = Spree::Taxon.find_or_create_by(name: 'Acuvue', taxonomy_id: 2)
        @taxon_gender = Spree::Taxon.find_or_create_by(name: 'Male', taxonomy_id: 3)
        @taxon_color_1 = Spree::Taxon.find_or_create_by(name: 'Black', taxonomy_id: 4)
        @taxon_color_2 = Spree::Taxon.find_or_create_by(name: 'Red', taxonomy_id: 4)
    end

    it "has a valid factory" do
        expect(product).to be_valid
    end

    context "category" do
        before do
            @taxon_category.products << product
        end

        it "returns taxon category" do
            expect(product.tx_category).to eq @taxon_category
        end

        it "returns taxon category name" do
            expect(product.category).to eq 'Contact Lenses'
        end

        context "checking if product has category" do
            it "returns true if product has category" do
                expect(product.category?).to be_true
            end

            it "returns false if product doesn't have category" do
                @taxon_category.destroy

                expect(product.category?).to be_false
            end
        end
    end

    context "brand" do
        before do
            @taxon_brand.products << product
        end

        it "returns taxon brand" do
            expect(product.tx_brand).to eq @taxon_brand
        end

        it "returns taxon brand name" do
            expect(product.brand).to eq 'Acuvue'
        end

        context "checking if product has brand" do
            it "returns true if product has brand" do
                expect(product.brand?).to be_true
            end

            it "returns false if product doesn't have brand" do
                @taxon_brand.destroy

                expect(product.brand?).to be_false
            end
        end
    end

    context "gender" do
        before do
            @taxon_gender.products << product
        end

        it "returns taxon gender" do
            expect(product.tx_gender).to eq @taxon_gender
        end

        it "returns taxon gender name" do
            expect(product.gender).to eq 'Male'
        end

        context "checking if product has gender" do
            it "returns true if product has gender" do
                expect(product.gender?).to be_true
            end

            it "returns false if product doesn't have gender" do
                @taxon_gender.destroy

                expect(product.gender?).to be_false
            end
        end
    end

    context "color" do
        before do
            @taxon_color_1.products << product
            @taxon_color_2.products << product
        end

        it "returns taxon colors" do
            expect(product.tx_colors).to eq [@taxon_color_1, @taxon_color_2]
        end

        it "returns basic color name" do
            expect(product.basic_color).to eq 'Black/Red'
        end

        context "checking if product has color" do
            it "returns true if product has color" do
                expect(product.color?).to be_true
            end

            it "returns false if product doesn't have color" do
                @taxon_color_1.destroy
                @taxon_color_2.destroy

                expect(product.color?).to be_false
            end
        end
    end
end
