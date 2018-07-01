class ContactsController < ApplicationController
    def new
        @contact = Contact.prg_get(flash)
        @contact ||= Contact.new

        if user_signed_in?
            @contact.email = current_user.email

            if current_user.addresses.any?
                @contact.name = current_user.addresses.first.first_name
                @contact.phone = current_user.addresses.first.phone
            end
        end
    end

    def create
        @contact = Contact.new(permitted_params)
        @contact.user = current_user if user_signed_in?

        if @contact.save
            redirect_to :root, notice: "Thanks! Your feedback has been submitted successfully."
        else
            Contact.prg_set(flash, @contact)
            redirect_to new_contact_path
        end
    end
end
