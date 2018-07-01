module Spree
    module Admin
        class ContactLensesController < ProductsController
            before_filter :set_variables, only: :index

            def model_class
                ::ContactLens
            end

            def model_name
                'product'
            end

            def object_name
                'product'
            end

            private
                def set_variables
                    @create_product_url = spree.admin_contact_lenses_path
                    @contact_lenses_controller = true
                    @create_product_label = Spree.t(:new_contact_lens)
                end
        end
    end
end
