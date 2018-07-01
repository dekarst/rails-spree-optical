class PrescriptionItem < ActiveRecord::Base
    belongs_to :prescription_category

    has_many :prescription_values, -> {order(:position)}, dependent: :destroy
    alias_attribute :values, :prescription_values

    validates :prescription_category, :name, presence: true

    accepts_nested_attributes_for :prescription_values, allow_destroy: true

    def name_to_display
        display_name || name
    end
end
