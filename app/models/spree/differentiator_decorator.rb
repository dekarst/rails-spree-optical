Spree::Stock::Differentiator.class_eval do
    private
        def build_required
            @required = Hash.new(0)
            order.line_items_without_non_buyables.each do |line_item|
                @required[line_item.variant] = line_item.quantity
            end
        end
end
