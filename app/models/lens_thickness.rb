class LensThickness < ActiveRecord::Base
    has_many :lens_thickness_options, -> {order(:position)}, dependent: :destroy
    alias_attribute :options, :lens_thickness_options

    validates :name, :image, presence: true

    mount_uploader :image, LensThicknessUploader

    def display_price
        options.first.display_price if options.any?
    end
end
