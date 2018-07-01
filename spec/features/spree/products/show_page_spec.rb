require 'spec_helper'

feature 'Product checkout' do
    before :each do
        @product = FactoryGirl.create(:product, name: 'Awesome Sunglasses')
    end

    scenario "doesn't have ContactLens specific info" do
        visit spree.product_path(@product)

        expect(page).to_not have_content('R (OD)')
        expect(page).to_not have_content('L (OS)')
        expect(page).to_not have_content('Power')
        expect(page).to_not have_content('BC')
        expect(page).to_not have_content('contact-lens-options')
    end
end
