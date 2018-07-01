class LensesController < ApplicationController
    before_filter :load_frame_line_item

    def create
        @frame_line_item.lens_id = params.require(:frame_line_item).permit![:lens_id]

        if @frame_line_item.lens_id_changed?
            if @frame_line_item.lens.present?
                if @frame_line_item.lens_thickness_option.present?
                    @frame_line_item.lens_thickness_option = nil unless @frame_line_item.lens.allowed_lens_thickness_option?(@frame_line_item.lens_thickness_option)
                end
                @frame_line_item.lens_protection_options = @frame_line_item.lens_protection_options.delete_if {|option| not @frame_line_item.lens.allowed_lens_protection_option?(option)}
            end

            LensLineItem.where(frame_line_item_id: @frame_line_item.id).destroy_all
            LensThicknessOptionLineItem.where(frame_line_item_id: @frame_line_item.id).each do |option_line_item|
                option_line_item.destroy if @frame_line_item.lens_thickness_option != option_line_item.variant
            end
            LensProtectionOptionLineItem.where(frame_line_item_id: @frame_line_item.id).each do |option_line_item|
                option_line_item.destroy unless @frame_line_item.lens_protection_options.include?(option_line_item.variant)
            end

            Prescription.where(prescriptionable_id: @frame_line_item.id, prescriptionable_type: 'Spree::LineItem').destroy_all
        end

        if @frame_line_item.lens.present?
            if @frame_line_item.save
                populator = Spree::OrderPopulator.new(current_order(true), current_currency)
                if populator.populate(variants: {@frame_line_item.lens.master.id => 1}, non_buyable_options: {frame_line_item_id: @frame_line_item.id})
                    redirect_to spree.select_prescription_orders_path(@frame_line_item.id)
                else
                    populator.errors.each do |k, v|
                        @frame_line_item.errors.add(:populator, v)
                    end

                    set_prg_and_redirect
                end
            else
                set_prg_and_redirect
            end
        else
            @frame_line_item.errors.add(:lens, "Should select a Lens")

            set_prg_and_redirect
        end
    end

    private
        def load_frame_line_item
            @frame_line_item = current_order(true).line_items.find_by!(id: params.require(:frame_line_item).permit![:id])

            @variant = @frame_line_item.variant
            @product = @variant.product

            if not @product.is_a?(Frame)
                Rollbar.error(Exception.new("LensesController#load_frame_line_item called when @product is not a Frame"))

                flash[:error] = "An error has occurred"
                redirect_to spree.cart_path
            end
        end

        def set_prg_and_redirect
            FrameLineItem.prg_set(flash, @frame_line_item)
            redirect_to spree.select_lens_orders_path(@frame_line_item.id)
        end
end
