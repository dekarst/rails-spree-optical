class PrescriptionEye < ActiveRecord::Base
    include Prescriptioner

    belongs_to :prescription
    has_many :prescription_options, dependent: :destroy

    validates :name, presence: true, inclusion: {in: %w(right left)}
    validate :includes_all_available_items
    validate :check_limitations
    validate :validate_quantity

    after_initialize :set_prescription_category
    after_update :update_order_total

    def pretty_name
        if name == 'right'
            'R (OD)'
        elsif name == 'left'
            'L (OS)'
        end
    end

    def selected_value(values)
        prescription_options.map {|o| o.prescription_value_id}.select {|v| values.include?(v)}.first
    end

    def value_name_for(item_id)
        prescription_options.find {|o| o.prescription_value.prescription_item_id == item_id}.try(:prescription_value).try(:name)
    end

    private
        def set_prescription_category
            self.prescription_category ||= PrescriptionCategory.first
        end

        def update_order_total
            if quantity_changed? or checked_changed?
                if prescription.present? and prescription.prescriptionable.present? and prescription.prescriptionable.is_a?(ContactLensLineItem)
                    prescription.prescriptionable.order.update_totals
                    prescription.prescriptionable.order.save
                end
            end
        end

        def includes_all_available_items
            if checked?
                items.each do |item|
                    values = item.values.map(&:id)
                    if prescription_options.select {|option| values.include?(option.prescription_value_id)}.empty?
                        errors.add(:prescription_options, "should choose #{item.name} option")
                    end
                end
            end
        end

        def check_limitations
            if prescription.present? and prescription.prescriptionable.present? and prescription.prescriptionable.is_a?(ContactLensLineItem)
                if contact_lens = prescription.prescriptionable.variant.product
                    prescription_options.each do |prescription_option|
                        if value = prescription_option.value
                            if not contact_lens.valid_value?(value)
                                errors.add(:prescription_options, "#{value.item.name} is invalid")
                            end
                        end
                    end
                end
            end
        end

        def validate_quantity
            errors.add(:quantity, "Can't be null") if checked? and prescription.present? and prescription.prescriptionable.present? and prescription.prescriptionable.is_a?(ContactLensLineItem) and quantity.nil?
        end
end
