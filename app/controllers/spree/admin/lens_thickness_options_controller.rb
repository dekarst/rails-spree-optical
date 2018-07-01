module Spree
    module Admin
        class LensThicknessOptionsController < ResourceController
            belongs_to 'lens_thickness', find_by: :id

            def model_class
                LensThicknessOption
            end
        end
    end
end
