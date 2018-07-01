module Spree
    module Admin
        class BasicProductsController < ProductsController
            def model_class
                Spree::Product
            end

            def model_name
                'product'
            end

            def object_name
                'product'
            end

            protected
                def collection
                    return @collection if @collection.present?
                    params[:q] ||= {}
                    params[:q][:deleted_at_null] ||= "1"

                    params[:q][:s] ||= "name asc"
                    @collection = super

                    @collection = @collection.where("type IS NULL")

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
    end
end
