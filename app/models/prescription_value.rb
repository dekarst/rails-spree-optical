class PrescriptionValue < ActiveRecord::Base
    belongs_to :prescription_item
    alias_attribute :item, :prescription_item

    validates :prescription_item, :name, presence: true
end
