class FrameLineItem < Spree::LineItem
    include Prescriptionable

    belongs_to :lens
    belongs_to :lens_thickness_option
    has_and_belongs_to_many :lens_protection_options, join_table: :lens_protection_options_spree_line_items, foreign_key: :spree_line_item_id
    has_many :non_buyable_line_items, dependent: :destroy

    validate :lens_thickness_option_belongs_to_lens
    validate :lens_protection_options_belong_to_lens
    validate :does_not_have_more_than_one_option_from_same_lens_protection

    def lens_required?
        variant.product.lens_required?
    end

    def ready_to_checkout?
        valid?

        errors.add(:checkout, "Should choose a Lens") if lens_required? and not lens.present?

        if lens_required? or lens.present? or prescription.present?
            errors.add(:checkout, "Should choose a Lens") unless lens.present?
            errors.add(:checkout, "Should choose a Lens Thickness") unless lens_thickness_option.present?
            errors.add(:checkout, "Should fill the Prescription") unless prescription.present?

            if prescription.present?
                errors.add(:checkout, prescription.errors.full_messages.join('<br />')) unless prescription.valid?
                errors.add(:checkout, prescription.left_eye.errors.full_messages.join('<br />')) unless prescription.left_eye.valid?
                errors.add(:checkout, prescription.right_eye.errors.full_messages.join('<br />')) unless prescription.right_eye.valid?
                errors.add(:checkout, "Should send prescription document") unless prescription.scanned_document.present?
            end
        end

        errors.empty?
    end

    def first_step_ready_to_checkout?
        if lens_required? then lens.present? else true end
    end

    def second_step_ready_to_checkout?
        if lens_required?
            prescription.present? and prescription.valid? and prescription.scanned_document.present? and
            prescription.left_eye.valid? and prescription.right_eye.valid? and lens.present?
        else
            if lens.present? or prescription.present?
                prescription.valid? and prescription.scanned_document.present? and prescription.left_eye.valid? and prescription.right_eye.valid?
            end
        end
    end

    def amount
        quantity * (price + lens_package_subtotal)
    end

    def lens_package_subtotal_html
        Spree::Money.new(lens_package_subtotal, currency: current_currency)
    end

    def frame_plus_lens_package
        Spree::Money.new(((variant.price_in(current_currency).price || 0) + lens_package_subtotal), currency: current_currency)
    end

    private
        def lens_thickness_option_belongs_to_lens
            if lens.present? and lens_thickness_option.present?
                errors.add(:lens_thickness_option, "is invalid") unless lens.lens_thicknesses.include?(lens_thickness_option.lens_thickness)
            end
        end

        def lens_protection_options_belong_to_lens
            if lens.present? and lens_protection_options.any?
                lens_protection_options.each do |option|
                    if not lens.lens_protections.include?(option.lens_protection)
                        errors.add(:lens_protection_options, "is invalid")
                        break
                    end
                end
            end
        end

        def does_not_have_more_than_one_option_from_same_lens_protection
            lens_protections = []

            if lens.present? and lens_protection_options.any?
                lens_protection_options.each do |option|
                    if lens_protections.include?(option.lens_protection_id)
                        errors.add(:lens_protection_options, "is invalid")
                        break
                    else
                        lens_protections << option.lens_protection_id
                    end
                end
            end
        end

        def lens_package_subtotal
            non_buyable_line_items.map(&:amount).sum
        end

        def current_currency
            Spree::Config[:currency]
        end
end
