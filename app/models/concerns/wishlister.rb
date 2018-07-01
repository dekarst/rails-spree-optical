module Wishlister
    extend ActiveSupport::Concern

    included do
        has_many :wishlists, dependent: :destroy
    end

    def wishlisted?(product)
        wishlists.find_by(product: product).present?
    end

    def add_to_wishlist(product)
        wishlists.create!(product: product)
    end

    def remove_from_wishlist(product)
        wishlists.where(product: product).destroy_all
    end
end
