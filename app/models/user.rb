class User < ActiveRecord::Base
    include Deviser
    include AddressableModel
    include Wishlister

    letsrate_rater

    has_many :orders, class_name: 'Spree::Order'

    validates :verify_18_years, acceptance: {accept: true, allow_nil: false}
end
