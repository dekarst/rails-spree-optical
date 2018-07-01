class OptionsController < ApplicationController
    respond_to :json

    def create
        load_frame_line_item

        if @frame_line_item.variant.product.is_a?(Frame)
            @frame_line_item.lens_thickness_option_id = params.require(:frame_line_item).permit![:lens_thickness_option_id]
            lens_protection_options = params.require(:frame_line_item).permit![:lens_protection_options]
            @frame_line_item.lens_protection_option_ids = lens_protection_options.map {|k, v| v} if lens_protection_options.present?

            @frame_line_item.save(validate: false)

            LensThicknessOptionLineItem.where(frame_line_item_id: @frame_line_item.id).each do |option_line_item|
                option_line_item.destroy if @frame_line_item.lens_thickness_option != option_line_item.variant
            end
            LensProtectionOptionLineItem.where(frame_line_item_id: @frame_line_item.id).each do |option_line_item|
                option_line_item.destroy unless @frame_line_item.lens_protection_options.include?(option_line_item.variant)
            end

            if @frame_line_item.lens_thickness_option.present?
                if @frame_line_item.save
                    populator = Spree::OrderPopulator.new(current_order(true), current_currency)

                    variants = {@frame_line_item.lens_thickness_option.master.id => 1}
                    @frame_line_item.lens_protection_options.each do |option|
                        variants[option.master.id] = 1
                    end

                    if populator.populate(variants: variants, non_buyable_options: {frame_line_item_id: @frame_line_item.id})
                        redirect_to spree.cart_path
                    else
                        populator.errors.each do |k, v|
                            @frame_line_item.errors.add(:populator, v)
                        end

                        FrameLineItem.prg_set(flash, @frame_line_item, add_fields: [:lens_protection_option_ids])
                        redirect_to spree.select_options_orders_path(@frame_line_item.id)
                    end
                else
                    FrameLineItem.prg_set(flash, @frame_line_item, add_fields: [:lens_protection_option_ids])
                    redirect_to spree.select_options_orders_path(@frame_line_item.id)
                end
            else
                @frame_line_item.errors.add(:lens_thickness, "Should select a Lens Thickness")

                FrameLineItem.prg_set(flash, @frame_line_item, add_fields: [:lens_protection_option_ids])
                redirect_to spree.select_options_orders_path(@frame_line_item.id)
            end
        else
            Rollbar.error(Exception.new("LensesController#create called when @frame_line_item.variant.product is not a Frame"))

            flash[:error] = "An error has occurred"
            redirect_to spree.cart_path
        end
    end

    def allowed_lenses
        if params.require(:frame_line_item).require(:prescription).permit![:chosen_method] == '2'
            all_lenses = Lens.all
            lenses = {}
            value_ids = {}

            [:left_eye, :right_eye].each do |eye|
                if (params.require(:frame_line_item).require(:prescription).require(eye).permit![:checked] - ['', false]).any?
                    value_ids[eye] = params.require(:frame_line_item).require(:prescription).require(eye).permit![:values]
                    if value_ids[eye].present? and value_ids[eye].any?
                        value_ids[eye] = value_ids[eye].compact.uniq.select {|n| n != ''}
                    else
                        value_ids[eye] = []
                    end
                end
            end
            value_ids[:left_eye] ||= []
            value_ids[:right_eye] ||= []

            value_ids = value_ids[:left_eye] | value_ids[:right_eye]

            value_ids.each do |value_id|
                value = PrescriptionValue.find(value_id)
                item = value.item

                lenses[value_id] = []
                all_lenses.each do |lens|
                    lenses[value_id] << lens.id if lens.allowed_value?(item, value.name)
                end
            end

            final_lenses = []
            lenses.each do |value, lenses|
                final_lenses = lenses if final_lenses.empty?

                final_lenses = final_lenses & lenses
            end

            render json: final_lenses.uniq
        else
            render json: {invalid: true}
        end
    end

    private
        def load_frame_line_item
            @line_item = current_order(true).line_items.find_by!(id: params.require(:frame_line_item).permit![:id])
            @frame_line_item = FrameLineItem.find(@line_item.id)
        end
end
