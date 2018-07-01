class ContactLensLineItem < Spree::LineItem
    include Prescriptionable

    before_destroy :destroy_prescription

    def price
        if read_attribute(:price).present? and prescription.present? and prescription.checked_eyes.any?
            read_attribute(:price).to_f * prescription.checked_eyes.sum(&:quantity)
        else
            super()
        end
    end

    def ready_to_checkout?
        valid?

        if prescription.present?
            errors.add(:checkout, prescription.errors.full_messages.join('<br />')) unless prescription.valid?
            errors.add(:checkout, prescription.left_eye.errors.full_messages.join('<br />')) unless prescription.left_eye.valid?
            errors.add(:checkout, prescription.right_eye.errors.full_messages.join('<br />')) unless prescription.right_eye.valid?
            errors.add(:checkout, "Should send prescription document") unless prescription.scanned_document.present?
        else
            errors.add(:checkout, "Should fill the Prescription")
        end

        errors.empty?
    end

    def first_step_ready_to_checkout?
        prescription.present? and prescription.valid? and prescription.scanned_document.present? and prescription.left_eye.valid? and prescription.right_eye.valid?
    end

    def has_products_to_recommend?
        variant.try(:product).try(:has_products_to_recommend?)
    end

    private
        def destroy_prescription
            prescription.try(:destroy)
        end
end
