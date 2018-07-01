module Spree
    module Admin
        class PrescriptionValuesController < Spree::Admin::BaseController
            def destroy
                prescription_value = PrescriptionValue.find(params[:id])
                prescription_value.destroy
                render text: nil
            end
        end
    end
end
