class VariantsController < ApplicationController
    respond_to :json

    before_filter :find_model
    before_filter :set_quantity

    def price
        currency = @variant.currency
        amount = @variant.amount_in(currency) * @quantity

        @price = Spree::Money.new(amount, {currency: currency}).to_html

        render json: {price: @price}
    end

    private
        def find_model
            @variant = Spree::Variant.find(params[:id])
        end

        def set_quantity
            @quantity = params[:quantity] || 1
            @quantity = @quantity.to_i
        end
end
