Spree::OrderContents.class_eval do
    # Get current line item for variant if exists (if variant doesn't belong to a ContactLens)
    # Add variant qty to line_item
    def add(variant, quantity=1, currency=nil, shipment=nil, options=nil)
        if variant.product.is_a?(ContactLens)
            line_item = order.line_items.detect do |line_item|
                line_item.variant_id == variant.id and
                line_item.prescription.send("#{options[:eye]}_eye".to_sym).prescription_options.map(&:prescription_value_id).map {|v| v.to_s}.sort == options[:values].map {|v| v.to_s}.sort
            end
        elsif variant.product.is_a?(Frame)
            line_item = nil
        elsif variant.product.is_a?(NonBuyable)
            line_item = order.line_items.detect do |line_item|
                line_item.variant_id == variant.id and
                line_item.frame_line_item_id == options[:frame_line_item_id]
            end
        else
            line_item = order.find_line_item_by_variant(variant)
        end

        add_to_line_item(line_item, variant, quantity, currency, shipment, options)
    end

    # Get current line item for variant and eye
    # Remove variant qty from line_item
    def remove(variant, quantity=1, shipment=nil, options=nil)
        if variant.product.is_a?(ContactLens)
            line_item = order.line_items.detect do |line_item|
                line_item.variant_id == variant.id and
                line_item.prescription.send("#{options[:eye]}_eye".to_sym).prescription_options.map(&:prescription_value_id).sort == options[:values].sort
            end
        elsif variant.product.is_a?(NonBuyable)
            line_item = order.line_items.detect do |line_item|
                line_item.variant_id == variant.id and
                line_item.frame_line_item_id == options[:frame_line_item_id]
            end
        else
            line_item = order.find_line_item_by_variant(variant)
        end

        unless line_item
            raise ActiveRecord::RecordNotFound, "Line item not found for variant #{variant.sku}"
        end

        remove_from_line_item(line_item, variant, quantity, shipment)
    end

    private
        def add_to_line_item(line_item, variant, quantity, currency=nil, shipment=nil, options=nil)
            prescription = nil
            prescription_eye = nil

            if line_item
                line_item.target_shipment = shipment
                line_item.currency = currency unless currency.nil?

                if line_item.is_a?(NonBuyableLineItem)
                    line_item.quantity = 1
                else
                    line_item.quantity += quantity.to_i
                end
            else
                options ||= {}
                line_item_attrs = {order: order, variant: variant, quantity: quantity}

                line_item_class = if variant.product.is_a?(ContactLens)
                    ContactLensLineItem
                elsif variant.product.is_a?(Frame)
                    FrameLineItem
                elsif variant.product.is_a?(Lens)
                    LensLineItem
                elsif variant.product.is_a?(LensThicknessOption)
                    LensThicknessOptionLineItem
                elsif variant.product.is_a?(LensProtectionOption)
                    LensProtectionOptionLineItem
                else
                    Spree::LineItem
                end

                line_item = line_item_class.new(line_item_attrs)
                order.line_items << line_item

                line_item.target_shipment = shipment
                if currency
                    line_item.currency = currency unless currency.nil?
                    line_item.price    = variant.price_in(currency).amount
                else
                    line_item.price    = variant.price
                end

                if line_item.is_a?(ContactLensLineItem)
                    prescription = Prescription.find_by(order: order, prescriptionable: line_item)
                    prescription ||= Prescription.new(order: order, prescriptionable: line_item)

                    prescription.set_prescription_category(line_item.product.prescription_category)

                    prescription.eyes.each do |eye|
                        eye_quantity = (options[eye.name].try(:[], :quantity) || 0).to_i
                        if eye_quantity > 0
                            options[eye.name][:values] ||= []
                            options[eye.name][:values].each do |value|
                                eye.prescription_options.build(prescription_value_id: value)
                            end
                            eye.quantity = eye_quantity
                            eye.checked = true
                            eye.save
                        end
                    end

                    line_item.errors.clear
                elsif line_item.is_a?(NonBuyableLineItem)
                    line_item.frame_line_item_id = options[:frame_line_item_id]

                    line_item.errors.clear
                end
            end

            line_item.save

            prescription.save(validate: false) if prescription and line_item.persisted?
            order.reload
            order.update_totals
            order.save

            line_item
        end
end
