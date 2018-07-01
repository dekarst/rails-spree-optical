module Wishlistable
    extend ActiveSupport::Concern

    included do
        has_many :wishlists, dependent: :destroy
    end
end
