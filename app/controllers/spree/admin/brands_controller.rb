module Spree
    module Admin
        class BrandsController < ResourceController
            def model_class
                Brand
            end
        end
    end
end
