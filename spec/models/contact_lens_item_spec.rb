require 'spec_helper'

describe ContactLensItem do
    let(:contact_lens_item) {FactoryGirl.create(:contact_lens_item)}

    it "has a valid factory" do
        expect(contact_lens_item).to be_valid
    end
end
