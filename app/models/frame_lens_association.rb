class FrameLensAssociation < ActiveRecord::Base
    belongs_to :frame
    belongs_to :lens

    validates :frame, :lens, presence: true
    validates :lens_id, uniqueness: {scope: :frame_id}
end
