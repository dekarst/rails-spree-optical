class Lens < NonBuyable
    belongs_to :lens_type
    belongs_to :prescription_category
    has_and_belongs_to_many :lens_protections, join_table: :lens_protections_lenses
    has_and_belongs_to_many :lens_thicknesses, join_table: :lens_thicknesses_lenses
    has_and_belongs_to_many :prescription_lens_rules, join_table: :lenses_prescription_lens_rules

    before_destroy {lens_protections.clear}
    before_destroy {lens_thicknesses.clear}
    before_destroy {prescription_lens_rules.clear}

    alias_attribute :rules, :prescription_lens_rules

    validates :lens_type, :prescription_category, presence: true

    def full_name
        "#{lens_type.name} #{name}"
    end

    def large_image
        images.first.attachment.url(:large) if images.any?
    end

    def allowed_value?(prescription_item, value)
        selected_rules = rules.where(prescription_item: prescription_item)
        return true if selected_rules.empty?

        selected_rules.any? {|r| r.allowed_value?(value)}
    end

    def allowed_lens_thickness_option?(option)
        lens_thicknesses.each do |lens_thickness|
            return true if lens_thickness == option.lens_thickness
        end

        return false
    end

    def allowed_lens_protection_option?(option)
        lens_protections.each do |lens_protection|
            return true if lens_protection == option.lens_protection
        end

        return false
    end
end
