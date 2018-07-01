Spree::Promotion::Rules::ItemTotal.class_eval do
    def eligible?(order, options = {})
        item_total = order.line_items_without_non_buyables.map(&:amount).sum
        item_total.send(preferred_operator == 'gte' ? :>= : :>, BigDecimal.new(preferred_amount.to_s))
    end
end
