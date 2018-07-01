class NonBuyable < Spree::Product
    model_name.class_eval do
        def route_key
            'products'
        end

        def singular_route_key
            'product'
        end
    end

    # def to_param
    #     "NonBuyable#{Array.new(9){rand(9)}.join}"
    # end

    def name_to_display
        display_name.present? ? display_name : name
    end
end
