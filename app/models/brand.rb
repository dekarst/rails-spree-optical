class Brand < ActiveRecord::Base
    default_scope -> {order('position ASC')}

    mount_uploader :image, BrandUploader
end
