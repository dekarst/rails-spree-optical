module Spree
    module Admin
        class LensProtectionOptionsController < ResourceController
            belongs_to 'lens_protection', find_by: :id

            def model_class
                LensProtectionOption
            end
        end
    end
end
