def product_page
    expect(page).to have_content('Awesome Contact Lens')
    click_link 'Quick Buy' and sleep 3

    expect(page.current_path).to eq spree.product_path(@product)
    expect(page).to have_content('AWESOME CONTACT LENS')
    expect(page).to have_content(19.99)
end

def cart_state
    expect(page.current_path).to eq spree.cart_path
    expect(page).to have_content('Awesome Contact Lens')
    expect(page).to have_content(19.99)
    click_button 'Checkout'
end

def address_state
    expect(page.current_path).to eq spree.checkout_state_path(state: :address)
    expect(page).to have_content('Billing Address')
    expect(page).to have_content(19.99)
    fill_in_address('#billing')
    click_button 'Save and Continue'
end

def delivery_state
    expect(page.current_path).to eq spree.checkout_state_path(state: :delivery)
    expect(page).to have_content('Shipping Method')
    expect(page).to have_content('Awesome Contact Lens')
    expect(page).to have_content(19.99)
    expect(page).to have_content('UPS Ground (USD)')
    expect(page).to have_content(5.00)
    click_button 'Save and Continue'
end

def payment_state
    expect(page.current_path).to eq spree.checkout_state_path(state: :payment)
    expect(page).to have_content('Payment Information')
    expect(page).to have_content(19.99)
    fill_in_card
    click_button 'Save and Continue'
end

def confirm_state
    expect(page.current_path).to eq spree.checkout_state_path(state: :confirm)
    expect(page).to have_content('Confirm')
    expect(page).to have_content(19.99)
    click_button 'Place Order'
end

def order_page(order)
    expect(page.current_path).to eq spree.order_path(order)
    expect(page).to have_content(order.number)
    expect(page).to have_content('Your order has been processed successfully')
    expect(page).to have_content(19.99)
    click_link 'Go Back To Store' and sleep 3
end
