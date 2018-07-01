class NonBuyableLineItem < Spree::LineItem
    belongs_to :frame_line_item

    validates :frame_line_item, presence: true
end
