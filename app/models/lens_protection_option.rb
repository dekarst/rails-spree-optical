class LensProtectionOption < NonBuyable
    belongs_to :lens_protection

    validates :lens_protection, presence: true

    def to_param
        full_name
    end

    def full_name
        "#{lens_protection.name} #{name}"
    end
end
