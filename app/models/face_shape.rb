class FaceShape < ActiveRecord::Base
    validates :name, :image, presence: true

    mount_uploader :image, FaceShapeUploader
end
