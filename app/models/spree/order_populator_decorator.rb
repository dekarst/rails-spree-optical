# Spree::OrderPopulator.class_eval do
#     def populate(from_hash)
#         from_hash[:products].each do |product_id, variant_id|
#             attempt_cart_add(variant_id, from_hash[:quantity], from_hash[:prescription_options], from_hash[:non_buyable_options])
#         end if from_hash[:products]

#         from_hash[:variants].each do |variant_id, quantity|
#             attempt_cart_add(variant_id, quantity, from_hash[:prescription_options], from_hash[:non_buyable_options])
#         end if from_hash[:variants]

#         valid?
#     end

#     private
#         def attempt_cart_add(variant_id, quantity, prescription_options=nil, non_buyable_options=nil)
#             quantity = quantity.to_i
#             # 2,147,483,647 is crazy.
#             # See issue #2695.
#             if quantity > 2_147_483_647
#                 errors.add(:base, Spree.t(:please_enter_reasonable_quantity, scope: :order_populator))
#                 return false
#             end

#             variant = Spree::Variant.find(variant_id)

#             line_item = if variant.product.is_a?(ContactLens)
#                 quantity = (prescription_options.try(:[], :right).try(:[], :quantity) || 0).to_i + (prescription_options.try(:[], :left).try(:[], :quantity) || 0).to_i

#                 if quantity > 0 then @order.contents.add(variant, 1, currency, nil, prescription_options) else nil end
#             elsif variant.product.is_a?(NonBuyable)
#                 non_buyable_options ||= {}

#                 @order.contents.add(variant, 1, currency, nil, {frame_line_item_id: non_buyable_options[:frame_line_item_id]})
#             else
#                 if quantity > 0 then @order.contents.add(variant, quantity, currency) else nil end
#             end

#             if line_item.present?
#                 if not line_item.valid?
#                     errors.add(:base, line_item.errors.messages.values.join(" "))
#                     return false
#                 end
#             else
#                 return false
#             end

#             return true
#         end
# end
