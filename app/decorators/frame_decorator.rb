class FrameDecorator < Spree::ProductDecorator
    delegate_all

    decorates_association :colors
end
