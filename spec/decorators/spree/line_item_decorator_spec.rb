require 'spec_helper'

describe Spree::LineItemDecorator do
    let!(:contact_lens) {FactoryGirl.create(:contact_lens, name: 'Awesome Contact Lens')}
    let!(:left_line_item) {FactoryGirl.create(:line_item_with_contact_lens, variant: contact_lens.master, eye: 'left')}
    let!(:right_line_item) {FactoryGirl.create(:line_item_with_contact_lens, variant: contact_lens.master, eye: 'right')}

    context "displaying the eye abbreviation" do
        context "eye is left" do
            it "displays variant name and L" do
                expect(left_line_item.decorate.name_with_eye).to eq 'Awesome Contact Lens (L)'
            end
        end

        context "eye is right" do
            it "displays variant name and R" do
                expect(right_line_item.decorate.name_with_eye).to eq 'Awesome Contact Lens (R)'
            end
        end
    end
end
