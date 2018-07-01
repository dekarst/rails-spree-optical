module Spree
    module Admin
        class FrameColorsController < ResourceController
            belongs_to 'spree/product', find_by: :permalink

            def model_class
                FrameColor
            end

            def index
                redirect_to edit_admin_product_path(@product) and return unless @product.is_a?(Frame)
            end

            def destroy
                @frame_color = FrameColor.find(params[:id])
                if @frame_color.destroy
                    flash[:success] = Spree.t('notice_messages.color_deleted')
                else
                    flash[:success] = Spree.t('notice_messages.color_not_deleted')
                end

                respond_with(@frame_color) do |format|
                    format.html {redirect_to admin_product_frame_colors_url(params[:product_id])}
                    format.js  {render_js_for_destroy}
                end
            end
        end
    end
end
