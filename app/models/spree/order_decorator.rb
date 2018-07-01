Spree::Order.class_eval do
    def line_items_without_non_buyables
        line_items.select {|li| !li.is_a?(NonBuyableLineItem)}
    end

    def line_items_ready_to_checkout?
        @invalid_line_items = line_items_without_non_buyables.select {|li| (li.is_a?(FrameLineItem) or li.is_a?(ContactLensLineItem)) and !li.ready_to_checkout?}

        @invalid_line_items.empty?
    end

    def invalid_line_items
        @invalid_line_items || []
    end
end
