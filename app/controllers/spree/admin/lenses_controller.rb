module Spree
    module Admin
        class LensesController < ProductsController
            before_filter :set_variables, only: :index

            def model_class
                Lens
            end

            def model_name
                'product'
            end

            def object_name
                'product'
            end

            def update
                params[:product][:lens_thickness_ids] ||= []
                params[:product][:lens_protection_ids] ||= []
                params[:product][:prescription_lens_rule_ids] ||= []

                super
            end

            private
                def set_variables
                    @create_product_url = spree.admin_lenses_path
                    @create_product_label = Spree.t(:new_lens)
                end
        end
    end
end
