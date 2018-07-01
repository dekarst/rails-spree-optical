module Spree
    module Admin
        class PrescriptionCategoriesController < ResourceController
            before_filter :setup_new_prescription_item, only: :edit

            def model_class
                PrescriptionCategory
            end

            def update_items_positions
                params[:positions].each do |id, index|
                    PrescriptionItem.where(id: id).update_all(position: index)
                end

                respond_to do |format|
                    format.js  {render text: 'Ok'}
                end
            end

            private
                def setup_new_prescription_item
                    @prescription_category.prescription_items.build if @prescription_category.prescription_items.empty?
                end
        end
    end
end
