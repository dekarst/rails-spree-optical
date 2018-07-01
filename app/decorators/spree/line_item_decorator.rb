class Spree::LineItemDecorator < Draper::Decorator
    delegate_all

    def name_with_eye
        if variant.present?
            eye_abbreviation = eye == 'left' ? 'L' : 'R'

            "#{variant.name} (#{eye_abbreviation})"
        end
    end
end
