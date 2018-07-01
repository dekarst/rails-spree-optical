def fill_in_address(container_id)
    within container_id do
        fill_in 'First Name', with: 'Dwight'
        fill_in 'Last Name', with: 'Schrute'
        within '#baddress1' do
            fill_in 'Street', with: 'Main Av.'
        end
        fill_in 'City', with: 'Scranton'
        select 'Nevada', from: 'order_bill_address_attributes_state_id'
        fill_in 'Zip', with: '12345'
        fill_in 'Phone', with: '+00 (12) 345-6789'
    end
end

def fill_in_card(delay=2)
    fill_in 'Card Number', with: ''
    fill_in 'Card Number', with: '4111111111111111'
    fill_in 'card_expiry', with: "#{Date.today.month} / #{(Date.today + 1.year).strftime('%y')}"
    fill_in 'Card Code', with: '123'

    sleep delay;
end
