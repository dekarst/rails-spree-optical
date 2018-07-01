module Spree
    module Admin
        class PrescriptionItemsController < ResourceController
            before_filter :setup_new_prescription_value, only: :edit

            def model_class
                PrescriptionItem
            end

            def location_after_save
                edit_admin_prescription_category_url(@object.prescription_category)
            end

            def destroy
                prescription_item = PrescriptionItem.find(params[:id])
                prescription_item.destroy
                render text: nil
            end

            def update_values_positions
                params[:positions].each do |id, index|
                    PrescriptionValue.where(id: id).update_all(position: index)
                end

                respond_to do |format|
                    format.js  {render text: 'Ok'}
                end
            end

            private
                def setup_new_prescription_value
                    @prescription_item.prescription_values.build if @prescription_item.prescription_values.empty?
                end
        end
    end
end
