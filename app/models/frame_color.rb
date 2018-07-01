class FrameColor < ActiveRecord::Base
    belongs_to :frame
    has_many :variants, class_name: 'Spree::Variant', dependent: :restrict_with_exception

    validates :frame, :name, presence: true
    validates :name, uniqueness: {scope: :frame_id}

    after_create :set_position

    mount_uploader :color_image, ColorUploader

    private
        def set_position
            self.update_column(:position, frame.colors.maximum(:position).to_i + 1)
        end
end
