class ContactObserver < ActiveRecord::Observer
    def after_create(contact)
        ContactMailer.email(contact).deliver
    end
end
