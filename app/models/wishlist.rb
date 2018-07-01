class Wishlist < ActiveRecord::Base
    belongs_to :user
    belongs_to :product, class_name: 'Spree::Product'
end
