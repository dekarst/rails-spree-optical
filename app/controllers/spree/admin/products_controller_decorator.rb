Spree::Admin::ProductsController.class_eval do
    def update
        if params[:product][:taxon_ids].present?
            params[:product][:taxon_ids] = params[:product][:taxon_ids].split(',')
        end
        if params[:product][:option_type_ids].present?
            params[:product][:option_type_ids] = params[:product][:option_type_ids].split(',')
        end
        if params[:product][:lens_ids].present?
            params[:product][:lens_ids] = params[:product][:lens_ids].split(',')
        end
        if params[:product][:lens_thickness_ids].present?
            params[:product][:lens_thickness_ids] = params[:product][:lens_thickness_ids].split(',')
        end
        if params[:product][:lens_protection_ids].present?
            params[:product][:lens_protection_ids] = params[:product][:lens_protection_ids].split(',')
        end
        if params[:product][:prescription_lens_rule_ids].present?
            params[:product][:prescription_lens_rule_ids] = params[:product][:prescription_lens_rule_ids].split(',')
        end

        super
    end

    def related
        load_resource

        @relation_types = Spree::RelationType.where(applies_to: ['Spree::Product', @product.class.name]).order('name')
    end

    def limitations
        redirect_to edit_admin_product_url(@product) unless @product.is_a?(ContactLens)
    end

    protected
        def collection
            return @collection if @collection.present?
            params[:q] ||= {}
            params[:q][:deleted_at_null] ||= "1"

            params[:q][:s] ||= "name asc"
            @collection = super

            @collection = @collection.with_deleted if params[:q].delete(:deleted_at_null).blank?
            # @search needs to be defined as this is passed to search_form_for
            @search = @collection.ransack(params[:q])
            @collection = @search.result.
                group_by_products_id.
                includes(product_includes).
                page(params[:page]).
                per(Spree::Config[:admin_products_per_page])

            if params[:q][:s].include?("master_default_price_amount")
                # PostgreSQL compatibility
                @collection = @collection.group("spree_prices.amount")
            end

            @collection
        end
end
