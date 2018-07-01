module AddressableModel
    extend ActiveSupport::Concern

    included do
        has_many :addresses, class_name: 'Spree::Address', dependent: :destroy

        accepts_nested_attributes_for :addresses, allow_destroy: true
    end
end
