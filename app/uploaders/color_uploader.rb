# encoding: utf-8

class ColorUploader < CarrierWave::Uploader::Base
    include CarrierWave::RMagick

    storage :file

    def store_dir
        "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    end

    process resize_to_limit: [25, 20]

    def extension_white_list
        %w(jpg jpeg gif png)
    end
end
