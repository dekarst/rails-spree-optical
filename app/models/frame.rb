class Frame < Spree::Product
    has_many :frame_lens_associations, dependent: :destroy
    has_many :lenses, through: :frame_lens_associations
    has_many :frame_colors, -> {order(:position)}, dependent: :destroy
    alias_attribute :colors, :frame_colors
    has_and_belongs_to_many :face_shapes, join_table: :face_shapes_spree_products, foreign_key: :spree_product_id
    alias_attribute :shapes, :face_shapes

    after_initialize :add_prototype
    before_create :set_lens_required_to_true

    model_name.class_eval do
        def route_key
            'products'
        end

        def singular_route_key
            'product'
        end
    end

    def all_option_types
        variants_including_master.map {|v| v.option_values.map {|ov| ov.option_type}}.flatten.uniq.sort {|ot| ot.position}
    end

    def images_from_color(color)
        color.variants.map {|v| v.images}.flatten.uniq
    end

    private
        def add_prototype
            self.prototype_id = Spree::Prototype.find_by!(name: 'FramePrototype').id
        end

        def set_lens_required_to_true
            self.lens_required = true
        end
end
