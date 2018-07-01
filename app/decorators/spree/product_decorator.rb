class Spree::ProductDecorator < Draper::Decorator
    delegate_all

    def gender
        h.image_tag("/images/labels/#{model.gender.downcase}.png", class: 'absolut glases') unless model.gender.nil?
    end
end
