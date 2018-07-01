Spree::Product.class_eval do
    include Wishlistable

    letsrate_rateable 'rating'

    delegate_belongs_to :master, :retail_price, :retail_price_in, :saved_price_in

    after_initialize :set_default_shipping
    after_initialize :set_default_tax

    def self.like_any_including_properties_and_taxons(fields, values)
        includes(:product_properties, :taxons).where(fields.map {|field|
            values.map {|value|
                arel_table[field].matches("%#{value}%").or(Spree::ProductProperty.arel_table[:value].matches("%#{value}%")).or(Spree::Taxon.arel_table[:name].matches("%#{value}%"))
            }.inject(:or)
        }.inject(:or))
    end

    def tx_category
        taxons.where(taxonomy: Spree::Taxonomy.find_by(name: 'Category')).first
    end

    def category
        tx_category.try(:name)
    end

    def category?
        tx_category.present?
    end

    def tx_brand
        taxons.where(taxonomy: Spree::Taxonomy.find_by(name: 'Brand')).first
    end

    def brand
        tx_brand.try(:name)
    end

    def brand?
        tx_brand.present?
    end

    def tx_gender
        taxons.where(taxonomy: Spree::Taxonomy.find_by(name: 'Gender')).first
    end

    def gender
        tx_gender.try(:name)
    end

    def gender?
        tx_gender.present?
    end

    def tx_colors
        taxons.where(taxonomy: Spree::Taxonomy.find_by(name: 'Color'))
    end

    def color?
        tx_colors.any?
    end

    def basic_color
        tx_colors.map {|c| c.name}.join('/')
    end

    def all_option_types
        variants_including_master.map {|v| v.option_values.map {|ov| ov.option_type}}.flatten.uniq.sort {|ot| ot.position}
    end

    def get_similar_products(limit=nil)
        similar = []
        similar = similar_products.limit(limit) if has_related_products?('similar_products') and similar_products.any?
        similar = random_similar_products(limit) if similar.empty?

        similar
    end

    def random_similar_products(limit=nil)
        random_products = []

        if !taxons.blank?
            taxons.each do |taxon|
                random_products += taxon.products.where("spree_products.id != #{id}")
            end
        end

        random_products.uniq!

        random_products = random_products[0, limit] if limit.present? and limit > 0
        random_products
    end

    private
        def set_default_shipping
            self.shipping_category ||= Spree::ShippingCategory.find_by(name: 'Default')
        end

        def set_default_tax
            self.tax_category ||= Spree::TaxCategory.find_by(name: 'Default')
        end

        def relations_for_relation_type(relation_type)
            related_ids = relations.where(:relation_type_id => relation_type.id).order(:position).pluck(:related_to_id)

            result = Spree::Product.where(:id => related_ids)
            result = result.merge(Spree::Product.relation_filter.all) if relation_filter
            result = related_ids.collect {|id| result.detect {|x| x.id == id} } if result.present?

            result
        end

        def relation_filter
            Spree::Product.relation_filter
        end
end
