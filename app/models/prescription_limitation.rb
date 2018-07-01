class PrescriptionLimitation < ActiveRecord::Base
    belongs_to :limitationable, polymorphic: true
    belongs_to :prescription_item
    alias_attribute :item, :prescription_item

    validates :limitationable, :prescription_item, presence: true
    validates :min, :max, numericality: true, allow_blank: true
    validate :min_is_lower_than_or_equal_to_max

    private
        def min_is_lower_than_or_equal_to_max
            if min.present? and max.present?
                errors.add(:min, "should be lower than or equals to Max") if min.to_f > max.to_f
            end
        end
end
