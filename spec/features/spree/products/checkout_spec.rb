require 'spec_helper'

feature 'Product checkout' do
    before :each do
        @product = FactoryGirl.create(:product, name: 'Awesome Contact Lens')
        @product.master.stock_items.first.update_attribute(:count_on_hand, 1)
    end

    context "User signed in" do
        before :each do
            @user = login
        end

        scenario "purchases a product", js: true do
            visit spree.root_path

            product_page
            click_button 'CHECK OUT'

            cart_state
            address_state
            delivery_state
            payment_state
            confirm_state

            order_page(Spree::Order.first)

            expect(page.current_path).to eq spree.root_path
        end
    end

    context "User non-signed in" do
        scenario "tries to purchase a product and is asked to sign in", js: true do
            visit spree.root_path

            product_page
            click_button 'CHECK OUT'

            cart_state

            expect(page.current_path).to eq new_user_session_path
        end

        scenario "signs in after adding product to cart and completes purchase", js: true do
            visit spree.root_path

            product_page
            click_button 'CHECK OUT'

            cart_state

            expect(page.current_path).to eq new_user_session_path

            user = FactoryGirl.create(:user, email: 'user@example.com')
            fill_in 'Email', with: 'user@example.com'
            fill_in 'Password', with: '123456'
            click_button 'Sign in'
            expect(page).to have_content('Signed in successfully')

            address_state
            delivery_state
            payment_state
            confirm_state

            order_page(Spree::Order.first)

            expect(page.current_path).to eq spree.root_path
        end
    end
end
