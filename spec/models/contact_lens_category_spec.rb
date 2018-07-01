require 'spec_helper'

describe ContactLensCategory do
    let(:contact_lens_category) {FactoryGirl.create(:contact_lens_category)}

    it "has a valid factory" do
        expect(contact_lens_category).to be_valid
    end
end
