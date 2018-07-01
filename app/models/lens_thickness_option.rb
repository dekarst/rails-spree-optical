class LensThicknessOption < NonBuyable
    belongs_to :lens_thickness

    validates :lens_thickness, presence: true

    # FIXME use concern to avoid DRY
    def to_param
        full_name
    end

    def full_name
        "#{lens_thickness.name} #{name}"
    end
end
