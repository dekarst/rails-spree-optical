class WishlistsController < ApplicationController
    before_filter :authenticate_user!
    before_filter :load_product

    def create
        current_user.add_to_wishlist(@product) unless current_user.wishlisted?(@product)

        render js: "$('#wishlist_container').html(#{wishlist_partial});"
    end

    def destroy
        current_user.remove_from_wishlist(@product) if current_user.wishlisted?(@product)

        render js: "$('#wishlist_container').html(#{wishlist_partial});"
    end

    private
        def load_product
            @product = Spree::Product.find_by!(id: params[:product_id])
        end

        def wishlist_partial
            render_to_string(partial: '/spree/products/wishlist').to_json
        end
end
