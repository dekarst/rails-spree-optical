module Spree
    module Admin
        class LensTypesController < ResourceController
            def model_class
                LensType
            end
        end
    end
end
