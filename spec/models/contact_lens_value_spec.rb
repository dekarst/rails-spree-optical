require 'spec_helper'

describe ContactLensValue do
    let(:contact_lens_value) {FactoryGirl.create(:contact_lens_value)}

    it "has a valid factory" do
        expect(contact_lens_value).to be_valid
    end
end
