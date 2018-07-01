class ContactLens < Spree::Product
    include Prescriptioner
    include Limitationable

    def self.decorator_class
        ContactLensClassDecorator
    end

    def has_products_to_recommend?
       has_related_products?('recommendeds') and recommendeds.any?
    end

    model_name.class_eval do
        def route_key
            'products'
        end

        def singular_route_key
            'product'
        end
    end

    def total_on_hand
        Float::INFINITY
    end
end
