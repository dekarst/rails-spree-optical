Spree::Stock::Packer.class_eval do
    def default_package
        package = Spree::Stock::Package.new(stock_location, order)
        order.line_items.each do |line_item|
            if not line_item.is_a?(NonBuyableLineItem)
                if Spree::Config.track_inventory_levels and not line_item.variant.product.is_a?(ContactLens)
                    next unless stock_location.stock_item(line_item.variant)

                    on_hand, backordered = stock_location.fill_status(line_item.variant, line_item.quantity)
                    package.add line_item.variant, on_hand, :on_hand if on_hand > 0
                    package.add line_item.variant, backordered, :backordered if backordered > 0
                else
                    package.add line_item.variant, line_item.quantity, :on_hand
                end
            end
        end
        package
    end
end
