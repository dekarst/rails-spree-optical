require 'spec_helper'

describe Spree::LineItem do
    before :each do
        @line_item = FactoryGirl.create(:line_item_with_contact_lens)
        @category = @line_item.variant.product.contact_lens_category
        item = FactoryGirl.create(:contact_lens_item, contact_lens_category: @category)
        @value = FactoryGirl.create(:contact_lens_value, contact_lens_item: item)
    end

    it "has a valid factory" do
        expect(@line_item).to be_valid
    end

    context "Contact Lens Options" do
        context "creating a new LineItemContactLensOption" do
            before :each do
                new_item = FactoryGirl.create(:contact_lens_item, contact_lens_category: @category)
                @new_value = FactoryGirl.create(:contact_lens_value, contact_lens_item: new_item)
            end

            it "is valid if includes all items" do
                @line_item.contact_lens_options.create(contact_lens_value: @value)
                @line_item.contact_lens_options.create(contact_lens_value: @new_value)

                expect(@line_item.reload).to be_valid
            end

            it "is invalid if doesn't include any option" do
                expect(@line_item.reload).to_not be_valid
            end

            it "is invalid if doesn't include all items" do
                @line_item.contact_lens_options.create(contact_lens_value: @value)

                expect(@line_item.reload).to_not be_valid
            end

            it "shows right error if doesn't include all items" do
                @line_item.variant.product.reload
                @line_item.reload
                @line_item.valid?

                expect(@line_item).to have(2).errors_on(:contact_lens_options)
            end

            it "keeps normal behaviour for LineItem that doesn't belong to a ContactLens" do
                line_item = FactoryGirl.create(:line_item)

                expect(line_item.reload).to be_valid
            end
        end
    end

    context "Eye" do
        context "belongs to a ContactLens" do
            it "returns the :eye" do
                @line_item.eye = 'left'

                expect(@line_item.eye).to eq 'left'
            end

            it "is invalid if eye is nil" do
                @line_item.eye = nil

                expect(@line_item).to_not be_valid
            end

            it "is invalid if eye is different than left or right" do
                @line_item.eye = 'wathever'

                expect(@line_item).to_not be_valid
            end

            it "is valid if eye is left" do
                @line_item.eye = 'left'

                expect(@line_item).to be_valid
            end

            it "is valid if eye is right" do
                @line_item.eye = 'right'

                expect(@line_item).to be_valid
            end
        end

        context "doesn't belong to a ContactLens" do
            before :each do
                @line_item = FactoryGirl.create(:line_item)
            end

            it "is valid if eye is nil" do
                @line_item.eye = nil

                expect(@line_item).to be_valid
            end

            it "is valid if eye is different than left or right" do
                @line_item.eye = 'wathever'

                expect(@line_item).to be_valid
            end
        end
    end
end
