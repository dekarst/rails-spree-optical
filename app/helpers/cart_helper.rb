module CartHelper
    def cart_quantity
        if @order.present? and @order.line_items_without_non_buyables.any?
            @order.line_items_without_non_buyables.reduce(0) {|sum, line_item| sum + Spree::LineItemDecorator.decorate(line_item).quantity}
        else
            0
        end
    end
end
