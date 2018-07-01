module Limitationable
    extend ActiveSupport::Concern

    included do
        has_many :limitations, as: :limitationable, class_name: 'PrescriptionLimitation', dependent: :destroy

        accepts_nested_attributes_for :limitations, allow_destroy: false

        after_save :build_limitations
    end

    def valid_value?(value)
        if limitation = limitations.find_by(prescription_item: value.prescription_item)
            return false if limitation.min.present? and value.name.to_f < limitation.min.to_f
            return false if limitation.max.present? and value.name.to_f > limitation.max.to_f
        end

        return true
    end

    private
        def build_limitations
            if prescription_category_id_changed?
                self.limitations.destroy_all

                if prescription_category.present?
                    prescription_category.items.each do |item|
                        self.limitations.create!(item: item)
                    end
                end
            end
        end
end
