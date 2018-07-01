module Spree
    module Admin
        class FramesController < ProductsController
            before_filter :set_variables, only: :index

            def model_class
                Frame
            end

            def model_name
                'product'
            end

            def object_name
                'product'
            end

            private
                def set_variables
                    @create_product_url = spree.admin_frames_path
                    @create_product_label = Spree.t(:new_frame)
                end
        end
    end
end
