require 'spec_helper'

feature 'ContactLens cart', js: true do
    before :each do
        setup_contact_lens_category

        @contact_lens = FactoryGirl.create(:contact_lens, name: 'Awesome Contact Lens', contact_lens_category: @contact_lens_category)
    end

    context "select both eyes" do
        before :each do
            visit spree.root_path
            click_link 'Quick Buy' and sleep 3

            select_options
            click_button 'CHECK OUT'

            expect(page.current_path).to eq spree.cart_path
        end

        scenario "cart shows ContactLens options info" do
            expect(page).to have_content('L (OS)')
            expect(page).to have_content('R (OD)')

            expect(page).to have_content('Power')
            expect(page).to have_content('-6.00')
            expect(page).to have_content('Base Curve (BC)')
            expect(page).to have_content('8.8')
            expect(page).to have_content('Diameter (DIA)')
            expect(page).to have_content('14.0')

            expect(page).to have_content('Qty')
            expect(page).to have_content('20')
        end

        scenario "cart shows both ContactLenses" do
            expect(all('tr.line-item').size).to eq 2
        end
    end

    context "select only left eye" do
        before :each do
            visit spree.root_path
            click_link 'Quick Buy' and sleep 3

            select_options
            all('#contact_lens_options_right_quantity option:first-child').first.select_option
            click_button 'CHECK OUT'

            expect(page.current_path).to eq spree.cart_path
        end

        scenario "cart shows only ContactLens options info for left eye" do
            expect(page).to have_content('L (OS)')
            expect(page).to_not have_content('R (OD)')

            expect(page).to have_content('Power')
            expect(page).to have_content('-6.00')
            expect(page).to have_content('Base Curve (BC)')
            expect(page).to have_content('8.8')
            expect(page).to have_content('Diameter (DIA)')
            expect(page).to have_content('14.0')

            expect(page).to have_content('Qty')
            expect(page).to have_content('20')
        end

        scenario "cart shows only one ContactLens" do
            expect(all('tr.line-item').size).to eq 1
        end
    end

    context "non ContactLens product" do
        before :each do
            @contact_lens.destroy
            @product = FactoryGirl.create(:product, name: 'Awesome Product')
            @product.master.stock_items.first.update_attribute(:count_on_hand, 1)

            visit spree.root_path
            click_link 'Quick Buy' and sleep 3

            click_button 'CHECK OUT'

            expect(page.current_path).to eq spree.cart_path
        end

        scenario "keeps normal behaviour" do
            expect(page).to_not have_content('L (OS)')
            expect(page).to_not have_content('R (OD)')
            expect(page).to_not have_content('Power')
            expect(page).to_not have_content('Base Curve (BC)')
            expect(page).to_not have_content('Diameter (DIA)')
        end
    end

    context "on Cart popover" do
        context "cart is empty" do
            scenario "display empty message" do
                visit root_path
                page.find('.cart-link').click

                expect(page.find('.cart .popover-content').text).to eq 'Your cart is empty'
            end
        end

        context "cart isn't empty" do
            before :each do
                visit spree.root_path
                click_link 'Quick Buy' and sleep 3

                select_options
                find('#contact_lens_options_right_quantity option[value="5"]').select_option
                find('#contact_lens_options_left_quantity option[value="6"]').select_option
                click_button 'CHECK OUT'

                expect(page.current_path).to eq spree.cart_path
            end

            scenario "display one LineItem when cart has one line item" do
                visit root_path
                page.find('.cart-link').click

                expect(page).to have_css('.cart .popover-content li', count: 2)
                expect(page.all('.cart .popover-content li')[0].text).to have_content 'Awesome Contact Lens (R)'
                expect(page.all('.cart .popover-content li')[0].text).to have_content '5'
                expect(page.all('.cart .popover-content li')[0].text).to have_content '19.99'
                expect(page.all('.cart .popover-content li')[1].text).to have_content 'Awesome Contact Lens (L)'
                expect(page.all('.cart .popover-content li')[1].text).to have_content '6'
                expect(page.all('.cart .popover-content li')[1].text).to have_content '19.99'
            end

            scenario "display two LineItems when cart has two line items" do
                @another_contact_lens = FactoryGirl.create(:contact_lens, name: 'Another Contact Lens', price: 29.99, contact_lens_category: @contact_lens_category)

                visit spree.root_path
                click_link 'Quick Buy', {href: spree.product_path(@another_contact_lens)} and sleep 3

                select_options
                find('#contact_lens_options_right_quantity option[value="7"]').select_option
                find('#contact_lens_options_left_quantity option[value="8"]').select_option
                click_button 'CHECK OUT'

                expect(page.current_path).to eq spree.cart_path

                visit root_path
                page.find('.cart-link').click

                expect(page).to have_css('.cart .popover-content li', count: 4)
                expect(page.all('.cart .popover-content li')[0].text).to have_content 'Awesome Contact Lens (R)'
                expect(page.all('.cart .popover-content li')[0].text).to have_content '5'
                expect(page.all('.cart .popover-content li')[0].text).to have_content '19.99'
                expect(page.all('.cart .popover-content li')[1].text).to have_content 'Awesome Contact Lens (L)'
                expect(page.all('.cart .popover-content li')[1].text).to have_content '6'
                expect(page.all('.cart .popover-content li')[1].text).to have_content '19.99'
                expect(page.all('.cart .popover-content li')[2].text).to have_content 'Another Contact Lens (R)'
                expect(page.all('.cart .popover-content li')[2].text).to have_content '7'
                expect(page.all('.cart .popover-content li')[2].text).to have_content '29.99'
                expect(page.all('.cart .popover-content li')[3].text).to have_content 'Another Contact Lens (L)'
                expect(page.all('.cart .popover-content li')[3].text).to have_content '8'
                expect(page.all('.cart .popover-content li')[3].text).to have_content '29.99'
            end
        end
    end
end
