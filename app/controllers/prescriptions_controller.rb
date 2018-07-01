class PrescriptionsController < ApplicationController
    before_filter :load_prescription

    def create
        left_eye = @prescription.left_eye
        right_eye = @prescription.right_eye
        eyes_errors = []
        document_error = nil

        [[left_eye, :left_eye], [right_eye, :right_eye]].each do |eye, eye_params|
            eye.prescription_options.destroy_all
            eye.quantity = nil

            eye.checked = (params.require(:line_item).require(:prescription_attributes).require(eye_params).permit![:checked] - ['', false]).any?

            if eye.checked?
                values = params.require(:line_item).require(:prescription_attributes).require(eye_params).permit![:values]

                values ||= []
                values = values - ['', ' ', nil]
                values.uniq!
                values.each do |value|
                    eye.prescription_options.build(prescription_value_id: value)
                end

                eye.assign_attributes(params.require(:line_item).require(:prescription_attributes).require(eye_params).permit(:quantity))
            end

            eye.save(validate: false)
            eye.valid?

            eye.errors.each do |k, v|
                eyes_errors << "#{eye.pretty_name}: #{v}"
            end
        end

        @prescription.assign_attributes(params.require(:line_item).require(:prescription_attributes).permit(:chosen_method, :scanned_document, :remove_scanned_document, :observation))

        @prescription.save(validate: false)

        document_error = "Should send prescription document" if @prescription.scanned_document.nil?

        case @prescription.chosen_method
        when 1
            flash[:error] = "This option isn't enabled yet"
            redirect_to :back
        when 2
            if @prescription.save
                if eyes_errors.empty? and document_error.nil?
                    if @line_item.save
                        if @line_item.is_a?(FrameLineItem)
                            redirect_to spree.select_options_orders_path(@line_item.id)
                        else
                            redirect_to spree.cart_path
                        end
                    else
                        set_prg_and_redirect
                    end
                else
                    eyes_errors.each do |eye_error|
                        @line_item.errors.add(:prescription_eyes, eye_error)
                    end
                    @line_item.errors.add(:prescription_eyes, document_error) if document_error.present?

                    set_prg_and_redirect
                end
            else
                @prescription.errors.each do |k, v|
                    @line_item.errors.add(:prescription, v)
                end

                set_prg_and_redirect
            end
        when 3
            flash[:error] = "This option isn't enabled yet"
            redirect_to :back
        else
            flash[:error] = "You have to choose an option"
            redirect_to :back
        end
    end

    private
        def load_prescription
            @line_item = current_order(true).line_items.find_by!(id: params.require(:line_item).permit![:id])

            @variant = @line_item.variant
            @product = @variant.product

            unless @product.is_a?(Frame) or @product.is_a?(ContactLens)
                Rollbar.error(Exception.new("PrescriptionsController#load_prescription called when @product is neither a Frame or a ContactLens"))

                flash[:error] = "An error has occurred"
                redirect_to spree.cart_path
            end

            @prescription = Prescription.find_by(order: current_order, prescriptionable: @line_item)
            if @line_item.is_a?(FrameLineItem)
                @prescription ||= Prescription.new(order: current_order, prescriptionable: @line_item)
                @prescription.set_prescription_category(@line_item.lens.prescription_category)
            end
        end

        def set_prg_and_redirect
            @line_item.class.prg_set(flash, @line_item)

            redirect_to spree.select_prescription_orders_path(@line_item.id)
        end
end
