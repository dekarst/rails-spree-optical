require 'spec_helper'

describe LineItemContactLensOption do
    it "has a valid factory" do
        line_item_contact_lens_option = FactoryGirl.create(:line_item_contact_lens_option)

        expect(line_item_contact_lens_option).to be_valid
    end

    it "dont allow same LineItem to add same ContactLensValue" do
        line_item = FactoryGirl.create(:line_item_with_contact_lens)
        item = FactoryGirl.create(:contact_lens_item, contact_lens_category: line_item.variant.product.contact_lens_category)
        contact_lens_value = FactoryGirl.create(:contact_lens_value, contact_lens_item: item)

        FactoryGirl.create(:line_item_contact_lens_option, line_item: line_item, contact_lens_value: contact_lens_value)

        invalid = FactoryGirl.build(:line_item_contact_lens_option, line_item: line_item, contact_lens_value: contact_lens_value)

        expect(invalid).to_not be_valid
    end

    it "dont allow value that doesn't belong to LineItem's ContactLens" do
        contact_lens = FactoryGirl.create(:contact_lens)
        another_contact_lens = FactoryGirl.create(:contact_lens)

        item = FactoryGirl.create(:contact_lens_item, contact_lens_category: another_contact_lens.contact_lens_category)
        value = FactoryGirl.create(:contact_lens_value, contact_lens_item: item)

        line_item = FactoryGirl.create(:line_item_with_contact_lens, variant: contact_lens.master)

        option = FactoryGirl.build(:line_item_contact_lens_option, line_item: line_item, contact_lens_value: value)

        expect(option).to_not be_valid
    end

    it "dont allow LineItem which variant isn't from a ContactLens" do
        product = FactoryGirl.create(:product)
        line_item = FactoryGirl.create(:line_item, variant: product.master)

        option = FactoryGirl.build(:line_item_contact_lens_option, line_item: line_item)

        expect(option).to_not be_valid
    end

    it "dont allow more than one Value for same Item" do
        line_item = FactoryGirl.create(:line_item_with_contact_lens)
        item = FactoryGirl.create(:contact_lens_item, contact_lens_category: line_item.variant.product.contact_lens_category)
        value = FactoryGirl.create(:contact_lens_value, contact_lens_item: item)
        another_value = FactoryGirl.create(:contact_lens_value, contact_lens_item: item)

        line_item.contact_lens_options.create(contact_lens_value: value)

        option = line_item.contact_lens_options.build(contact_lens_value: another_value)

        expect(option).to_not be_valid
    end
end
