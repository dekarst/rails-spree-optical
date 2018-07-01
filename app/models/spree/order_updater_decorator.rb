Spree::OrderUpdater.class_eval do
    delegate :line_items_without_non_buyables, to: :order

    def update_totals
        order.payment_total = payments.completed.map(&:amount).sum
        order.item_total = line_items_without_non_buyables.map(&:amount).sum
        order.adjustment_total = adjustments.eligible.map(&:amount).sum
        order.total = order.item_total + order.adjustment_total
    end
end
