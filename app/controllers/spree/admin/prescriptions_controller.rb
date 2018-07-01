module Spree
    module Admin
        class PrescriptionsController < ResourceController
            belongs_to 'user', find_by: :id

            def model_class
                Prescription
            end
        end
    end
end
