module Prescriptionable
    extend ActiveSupport::Concern

    included do
        has_one :prescription, as: :prescriptionable, dependent: :nullify

        accepts_nested_attributes_for :prescription
    end

    def prescription_options_to_display
        prescription_options = []
        prescription.checked_eyes.each do |eye|
            eye.items.each do |item|
                prescription_options << item unless prescription_options.include?(item)
            end
        end

        prescription_options
    end
end
