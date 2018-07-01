class FrameColorDecorator < Draper::Decorator
    delegate_all

    def display_color
        if use_image?
            h.image_tag color_image_url, style: "width: 25px; height: 20px"
        else
            h.content_tag :div, nil, style: "background: #{(color_code.blank? ? '#000' : color_code)}; width: 25px; height: 20px"
        end
    end
end
