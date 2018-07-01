require 'spec_helper'

feature 'ContactLens checkout', js: true do
    before :each do
        setup_contact_lens_category

        @contact_lens = FactoryGirl.create(:contact_lens, name: 'Awesome Contact Lens', contact_lens_category: @contact_lens_category)
    end

    scenario "purchases a contact lens" do
        visit spree.root_path

        expect(page).to have_content('Awesome Contact Lens')
        click_link 'Quick Buy' and sleep 3

        contact_lens_page
        select_options

        click_button 'CHECK OUT'

        expect(page.current_path).to eq spree.cart_path
        expect(page).to have_content('Awesome Contact Lens')
        expect(page).to have_content(19.99)
    end

    context "forget to select" do
        before :each do
            visit spree.product_path(@contact_lens)
            select_options
        end

        scenario "Power" do
            all('#contact_lens_options_right_values_ option:first-child').first.select_option

            click_button 'CHECK OUT'

            expect(page.current_path).to eq spree.product_path(@contact_lens)
            expect(page).to have_content('should choose Power option')
        end

        scenario "BC" do
            all('#contact_lens_options_right_values_ option:first-child').last.select_option

            click_button 'CHECK OUT'

            expect(page.current_path).to eq spree.product_path(@contact_lens)
            expect(page).to have_content('should choose Base Curve (BC) option')
        end
    end

    scenario "starts with quantity = 1 selected" do
        visit spree.product_path(@contact_lens)

        expect(find('#contact_lens_options_right_quantity option[value="1"]')).to be_selected
        expect(find('#contact_lens_options_left_quantity option[value="1"]')).to be_selected

        sleep 2

        expect(find('#product-price .price').text).to eq '$39.98'
    end

    context "update price when select" do
        before :each do
            visit spree.product_path(@contact_lens)
            find('#contact_lens_options_left_quantity option:first-child').select_option
            find('#contact_lens_options_right_quantity option:first-child').select_option
        end

        scenario "Left Quantity = 1" do
            find('#contact_lens_options_left_quantity option[value="1"]').select_option
            sleep 2

            expect(find('#product-price .price').text).to eq '$19.99'
        end

        scenario "Left Quantity = 2" do
            find('#contact_lens_options_left_quantity option[value="2"]').select_option
            sleep 2

            expect(find('#product-price .price').text).to eq '$39.98'
        end

        scenario "Left Quantity = 20" do
            find('#contact_lens_options_left_quantity option[value="20"]').select_option
            sleep 2

            expect(find('#product-price .price').text).to eq '$399.80'
        end

        scenario "Right Quantity = 1" do
            find('#contact_lens_options_right_quantity option[value="1"]').select_option
            sleep 2

            expect(find('#product-price .price').text).to eq '$19.99'
        end

        scenario "Right Quantity = 10" do
            find('#contact_lens_options_right_quantity option[value="10"]').select_option
            sleep 2

            expect(find('#product-price .price').text).to eq '$199.90'
        end

        scenario "Left Quantity = 2 and Right Quantity = 4" do
            find('#contact_lens_options_left_quantity option[value="2"]').select_option
            find('#contact_lens_options_right_quantity option[value="4"]').select_option
            sleep 2

            expect(find('#product-price .price').text).to eq '$119.94'
        end
    end

    context "add to cart" do
        before :each do
            visit spree.product_path(@contact_lens)
        end

        scenario "set 3 options (Power, BC, DIA) to Line Item for each eye" do
            select_options

            click_button 'CHECK OUT'
            expect(page.current_path).to eq spree.cart_path

            order = Spree::Order.last
            expect(order.line_items.size).to eq 2

            order.line_items.each do |line_item|
                expect(line_item.contact_lens_options.size).to eq 3
            end
        end

        scenario "set Power to line item (left eye)" do
            select_options

            click_button 'CHECK OUT'
            expect(page.current_path).to eq spree.cart_path

            order = Spree::Order.last
            expect(order.line_items.size).to eq 2
            line_item = order.line_items.where(eye: 'left').first

            expect(line_item.contact_lens_options.where(contact_lens_value: @item_power.values.last).size).to eq 1
        end

        scenario "set Power to line item (right eye)" do
            select_options

            click_button 'CHECK OUT'
            expect(page.current_path).to eq spree.cart_path

            order = Spree::Order.last
            expect(order.line_items.size).to eq 2
            line_item = order.line_items.where(eye: 'right').first

            expect(line_item.contact_lens_options.where(contact_lens_value: @item_power.values.last).size).to eq 1
        end

        scenario "set BC to line item (left eye)" do
            select_options

            click_button 'CHECK OUT'
            expect(page.current_path).to eq spree.cart_path

            order = Spree::Order.last
            expect(order.line_items.size).to eq 2
            line_item = order.line_items.where(eye: 'left').first

            expect(line_item.contact_lens_options.where(contact_lens_value: @item_bc.values.last).size).to eq 1
        end

        scenario "set BC to line item (right eye)" do
            select_options

            click_button 'CHECK OUT'
            expect(page.current_path).to eq spree.cart_path

            order = Spree::Order.last
            expect(order.line_items.size).to eq 2
            line_item = order.line_items.where(eye: 'right').first

            expect(line_item.contact_lens_options.where(contact_lens_value: @item_bc.values.last).size).to eq 1
        end

        scenario "set Quantity to line item (left eye)" do
            select_options

            click_button 'CHECK OUT'
            expect(page.current_path).to eq spree.cart_path

            order = Spree::Order.last
            line_item = order.line_items.where(eye: 'left').first

            expect(line_item.quantity).to eq 20
        end

        scenario "set Quantity to line item (right eye)" do
            select_options

            click_button 'CHECK OUT'
            expect(page.current_path).to eq spree.cart_path

            order = Spree::Order.last
            line_item = order.line_items.where(eye: 'right').first

            expect(line_item.quantity).to eq 20
        end

        scenario "adds two line items to order" do
            select_options

            click_button 'CHECK OUT'
            expect(page.current_path).to eq spree.cart_path

            order = Spree::Order.last
            expect(order.line_items.size).to eq 2
        end

        scenario "shows the two line items in cart" do
            select_options

            click_button 'CHECK OUT'
            expect(page.current_path).to eq spree.cart_path

            expect(all('#cart-detail tr.line-item').size).to eq 2
        end
    end
end
