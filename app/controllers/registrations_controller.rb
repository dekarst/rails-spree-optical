class RegistrationsController < Devise::RegistrationsController
    def new
        self.resource = User.prg_get(flash)
        build_resource({}) unless self.resource

        @address = Spree::Address.prg_get(flash)
        self.resource.addresses << @address if @address.present?
        @address ||= self.resource.addresses.build

        respond_with self.resource
    end

    def create
        build_resource(sign_up_params.merge(params.require(:user).permit(:accepts_newsletters, :verify_18_years, addresses_attributes: [:firstname, :lastname, :phone, :address1, :address2, :city, :state_id, :state_name, :zipcode, :country_id])))

        if resource.save
            if resource.active_for_authentication?
                set_flash_message :notice, :signed_up if is_navigational_format?
                sign_up(resource_name, resource)
                respond_with resource, location: after_sign_up_path_for(resource)
            else
                set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
                expire_session_data_after_sign_in!
                respond_with resource, location: after_inactive_sign_up_path_for(resource)
            end
        else
            clean_up_passwords resource

            if resource.errors.has_key?(:'addresses.state')
                resource.errors[:'addresses.state_id'] = resource.errors[:'addresses.state']
                resource.errors[:'addresses.state_name'] = resource.errors[:'addresses.state']
                resource.errors[:'addresses.state_id'].flatten!
                resource.errors[:'addresses.state_name'].flatten!
            end

            User.prg_set(flash, resource)
            Spree::Address.prg_set(flash, resource.addresses.first) if resource.addresses.any?

            redirect_to new_registration_path(resource)
        end
    end
end
