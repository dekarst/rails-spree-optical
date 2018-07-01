Spree::OrdersController.class_eval do
    def update
        @order = current_order
        unless @order
            flash[:error] = Spree.t(:order_not_found)
            redirect_to root_path and return
        end

        if @order.update_attributes(order_params)
            @order.line_items = @order.line_items.select {|li| li.quantity > 0 }
            @order.ensure_updated_shipments
            return if after_update_attributes

            fire_event('spree.order.contents_changed')

            respond_with(@order) do |format|
                format.html do
                    if params.has_key?(:checkout)
                        if @order.line_items_ready_to_checkout?
                            @order.next_transition.run_callbacks if @order.cart?
                            redirect_to checkout_state_path(@order.checkout_steps.first)
                        else
                            line_item = @order.invalid_line_items.first
                            if line_item.present?
                                if line_item.first_step_ready_to_checkout?
                                    if line_item.is_a?(FrameLineItem)
                                        if line_item.second_step_ready_to_checkout?
                                            FrameLineItem.prg_set(flash, line_item)
                                            redirect_to spree.select_options_orders_path(line_item.id)
                                        else
                                            FrameLineItem.prg_set(flash, line_item)
                                            redirect_to spree.select_prescription_orders_path(line_item.id)
                                        end
                                    else
                                        Rollbar.error(Exception.new("OrdersController#update :invalid_line_items called when line_item is ready to checkout"))
                                        redirect_to spree.cart_path
                                    end
                                else
                                    line_item.class.prg_set(flash, line_item)

                                    if line_item.is_a?(FrameLineItem)
                                        redirect_to spree.select_lens_orders_path(line_item.id)
                                    elsif line_item.is_a?(ContactLensLineItem)
                                        redirect_to spree.select_prescription_orders_path(line_item.id)
                                    end
                                end
                            else
                                Rollbar.error(Exception.new("OrdersController#update called when @order.invalid_line_items is empty"))
                                redirect_to cart_path
                            end
                        end
                    else
                        redirect_to cart_path
                    end
                end
            end
        else
            respond_with(@order)
        end
    end

    # Adds a new item to the order (creating a new order if none already exists)
    def populate
        populator = Spree::OrderPopulator.new(current_order(true), current_currency)
        from_hash = params.slice(:products, :variants, :quantity, :prescription_options)

        if populator.populate(from_hash)
            current_order.ensure_updated_shipments

            fire_event('spree.cart.add')
            fire_event('spree.order.contents_changed')

            variant_id = nil
            variant_id = from_hash[:products].values.first if from_hash[:products] and from_hash[:products].values.any?
            variant_id = from_hash[:variants].keys.first if from_hash[:variants] and from_hash[:variants].keys.any?

            if variant_id.present?
                if frame_line_item = @current_order.line_items.find_by(type: 'FrameLineItem', variant_id: variant_id)
                    if not frame_line_item.lens_required? and params.key?('checkout-without-lenses')
                        respond_with(@order) do |format|
                            format.html {redirect_to cart_path}
                        end
                    else
                        redirect_to select_lens_orders_path(frame_line_item.id)
                    end
                elsif contact_lens_line_item = @current_order.line_items.find_by(type: 'ContactLensLineItem', variant_id: variant_id)
                    if contact_lens_line_item.has_products_to_recommend?
                        redirect_to recommendations_orders_path(contact_lens_line_item.id)
                    else
                        redirect_to select_prescription_orders_path(contact_lens_line_item.id)
                    end
                else
                    respond_with(@order) do |format|
                        format.html {redirect_to cart_path}
                    end
                end
            else
                respond_with(@order) do |format|
                    format.html do
                        flash[:error] = "You need to select a Product"
                        redirect_to :back
                    end
                end
            end
        else
            flash[:error] = populator.errors.full_messages.join('<br/>')
            redirect_to :back
        end
    end

    def select_lens
        load_frame_line_item

        if @product.is_a?(Frame)
            @lenses = @product.lenses

            warranty = PageContent.by_slug('warranty-page-content').first
            @warranty_page_content = warranty.body if warranty.present?
        else
            Rollbar.error(Exception.new("OrdersController#select_lens called when @product is not a Frame"))

            flash[:error] = "An error has occurred"
            redirect_to spree.cart_path
        end
    end

    def select_prescription
        load_line_item

        if @product.is_a?(Frame)
            if @line_item.lens.present?
                build_prescription_options

                warranty = PageContent.by_slug('warranty-page-content').first
                @warranty_page_content = warranty.body if warranty.present?
            else
                flash[:error] = "You need to choose a Lens first"
                redirect_to select_lens_orders_path(@line_item.id)
            end
        elsif @product.is_a?(ContactLens)
            build_prescription_options

            warranty = PageContent.by_slug('warranty-page-content').first
            @warranty_page_content = warranty.body if warranty.present?
        else
            Rollbar.error(Exception.new("OrdersController#select_prescription called when @product is neither a Frame or a ContactLens"))

            flash[:error] = "An error has occurred"
            redirect_to spree.cart_path
        end
    end

    def select_options
        load_frame_line_item

        if @product.is_a?(Frame)
            if @frame_line_item.lens.present?
                @lens_thicknesses = @frame_line_item.lens.lens_thicknesses
                @lens_protections = @frame_line_item.lens.lens_protections

                warranty = PageContent.by_slug('warranty-page-content').first
                @warranty_page_content = warranty.body if warranty.present?
            else
                flash[:error] = "You need to choose a Lens first"
                redirect_to select_lens_orders_path(@frame_line_item.id)
            end
        else
            Rollbar.error(Exception.new("OrdersController#select_options called when @product is not a Frame"))

            flash[:error] = "An error has occurred"
            redirect_to spree.cart_path
        end
    end

    def recommendations
        load_line_item

        if @product.has_products_to_recommend?
            @recommended_products = @product.recommendeds

            warranty = PageContent.by_slug('warranty-page-content').first
            @warranty_page_content = warranty.body if warranty.present?
        else
            Rollbar.error(Exception.new("ProductsController#recommendations called when @product has no products to recommend"))

            redirect_to spree.cart_path
        end
    end

    def add_recommendations
        load_line_item

        if params[:recommended_product].try(:[], :buy_together) and params[:recommended_product][:buy_together].any?
            from_hash = {variants: {}}

            params[:recommended_product][:buy_together].each do |recommended_product_id|
                from_hash[:variants][Spree::Product.find(recommended_product_id).master.id] = 1
            end

            populator = Spree::OrderPopulator.new(current_order(true), current_currency)

            if populator.populate(from_hash)
                redirect_to select_prescription_orders_path(@line_item.id)
            else
                flash[:error] = populator.errors.full_messages.join('<br/>')
                redirect_to recommendations_orders_path(@line_item.id)
            end
        else
            redirect_to select_prescription_orders_path(@line_item.id)
        end
    end

    private
        def build_prescription_options
            if @product.is_a?(Frame)
                @prescription = Prescription.find_by(order: current_order, prescriptionable: @frame_line_item)
                @prescription ||= Prescription.new(order: current_order, prescriptionable: @frame_line_item)
                @prescription.set_prescription_category(@frame_line_item.lens.prescription_category)

                @prescription_options = {}
                @frame_line_item.lens.prescription_category.items.each do |item|
                    @prescription_options[item.name_to_display] = item.values
                end

                @prescription.prescriptionable = @frame_line_item
            elsif @product.is_a?(ContactLens)
                @prescription = @line_item.prescription if @line_item.present?

                @prescription_options = {}
                @product.items.each do |item|
                    @prescription_options[item.name_to_display] = item.values.select {|v| @product.valid_value?(v)}
                end
            end
        end

        def load_frame_line_item
            @frame_line_item = FrameLineItem.prg_get(flash)

            if @frame_line_item.nil?
                line_item = current_order(true).line_items.find_by!(id: params[:line_item_id])
                @frame_line_item = FrameLineItem.find(line_item.id)
            end

            @variant = @frame_line_item.variant
            @product = @variant.product
        end

        def load_line_item
            @line_item = FrameLineItem.prg_get(flash)
            @line_item ||= ContactLensLineItem.prg_get(flash)

            if @line_item.present?
                line_item = current_order(true).line_items.find_by!(id: params[:line_item_id])
                @line_item.prescription = line_item.prescription
            else
                line_item = current_order(true).line_items.find_by!(id: params[:line_item_id])
                @line_item = Spree::LineItem.find(line_item.id)
            end

            @variant = @line_item.variant
            @product = @variant.product
        end
end
