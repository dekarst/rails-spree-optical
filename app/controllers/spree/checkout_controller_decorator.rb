Spree::CheckoutController.class_eval do
    before_filter :authenticate_user!
    before_filter :fill_address, only: :edit

    private
        def fill_address
            if current_order.present? and current_order.address? and user_signed_in? and current_user.addresses.any?
                current_order.bill_address.assign_attributes({
                    firstname: current_user.addresses.first.firstname,
                    lastname: current_user.addresses.first.lastname,
                    address1: current_user.addresses.first.address1,
                    address2: current_user.addresses.first.address2,
                    city: current_user.addresses.first.city,
                    zipcode: current_user.addresses.first.zipcode,
                    phone: current_user.addresses.first.phone,
                    state_name: current_user.addresses.first.state_name,
                    alternative_phone: current_user.addresses.first.alternative_phone,
                    company: current_user.addresses.first.company,
                    state_id: current_user.addresses.first.state_id,
                    country_id: current_user.addresses.first.country_id,
                })

                current_order.ship_address.assign_attributes({
                    firstname: current_user.addresses.first.firstname,
                    lastname: current_user.addresses.first.lastname,
                    address1: current_user.addresses.first.address1,
                    address2: current_user.addresses.first.address2,
                    city: current_user.addresses.first.city,
                    zipcode: current_user.addresses.first.zipcode,
                    phone: current_user.addresses.first.phone,
                    state_name: current_user.addresses.first.state_name,
                    alternative_phone: current_user.addresses.first.alternative_phone,
                    company: current_user.addresses.first.company,
                    state_id: current_user.addresses.first.state_id,
                    country_id: current_user.addresses.first.country_id,
                })
            end
        end
end
