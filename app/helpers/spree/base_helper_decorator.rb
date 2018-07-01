Spree::BaseHelper.module_eval do
    def display_retail_price(product_or_variant)
        product_or_variant.retail_price_in(current_currency).display_retail_price.to_html
    end

    def display_saved_price(product_or_variant)
        product_or_variant.saved_price_in(current_currency).display_price.to_html
    end
end
