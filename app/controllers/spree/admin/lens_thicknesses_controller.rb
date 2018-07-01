module Spree
    module Admin
        class LensThicknessesController < ResourceController
            def model_class
                LensThickness
            end

            protected
                def collection
                    return @collection if @collection.present?

                    @collection = super

                    @collection = @collection.
                        page(params[:page]).
                        per(Spree::Config[:admin_products_per_page])

                    @collection
                end
        end
    end
end
