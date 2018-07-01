class PrescriptionCategory < ActiveRecord::Base
    has_many :contact_lenses, dependent: :restrict_with_exception
    has_many :prescription_eyes, dependent: :restrict_with_exception

    has_many :prescription_items, -> {order(:position)}, dependent: :destroy
    alias_attribute :items, :prescription_items

    validates :name, presence: true

    accepts_nested_attributes_for :prescription_items, allow_destroy: true
end
