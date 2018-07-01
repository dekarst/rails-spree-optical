Spree::Admin::ImagesController.class_eval do
    private
        def load_data
            @product = Spree::Product.find_by_permalink(params[:product_id])
            @variants = if @product.is_a?(Frame)
                @product.variants.collect do |variant|
                    [variant.color_and_options_text, variant.id]
                end
            else
                @product.variants.collect do |variant|
                    [variant.options_text, variant.id]
                end
            end
            @variants.insert(0, [Spree.t(:all), @product.master.id])
        end
end
