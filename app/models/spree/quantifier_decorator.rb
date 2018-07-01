Spree::Stock::Quantifier.class_eval do
    def total_on_hand
        variant = Spree::Variant.find(@variant)

        if Spree::Config.track_inventory_levels and not variant.product.is_a?(ContactLens)
            stock_items.to_a.sum(&:count_on_hand)
        else
            Float::INFINITY
        end
    end
end
