class PrescriptionOption < ActiveRecord::Base
    belongs_to :prescription_eye, polymorphic: true

    belongs_to :prescription_value
    alias_attribute :value, :prescription_value

    validates :prescription_value, presence: true
    validates :prescription_value_id, uniqueness: {scope: :prescription_eye_id}
    validate :value_belongs_to_same_prescription_eye
    validate :only_one_value_for_each_item

    private
        def value_belongs_to_same_prescription_eye
            if prescription_eye.present? and prescription_value.present?
                if prescription_eye.prescription_category != prescription_value.prescription_item.prescription_category
                    errors.add(:prescription_value, "has an invalid Category")
                end
            end
        end

        def only_one_value_for_each_item
            if prescription_eye.present? and prescription_value.present?
                values = prescription_value.prescription_item.values.map {|v| v.id}.delete_if {|id| id == prescription_value.id}
                if prescription_eye.prescription_options.where(prescription_value_id: values).exists?
                    errors.add(:prescription_value, "only one can be choosen for each Item")
                end
            end
        end
end
