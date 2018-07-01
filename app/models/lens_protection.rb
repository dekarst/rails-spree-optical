class LensProtection < ActiveRecord::Base
    has_and_belongs_to_many :lenses, join_table: :lens_protections_lenses
    has_many :lens_protection_options, -> {order(:position)}, dependent: :destroy
    alias_attribute :options, :lens_protection_options

    validates :name, :image, presence: true

    mount_uploader :image, LensThicknessUploader

    def display_price
        options.first.display_price if options.any?
    end
end
