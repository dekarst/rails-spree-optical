module Prescriptioner
    extend ActiveSupport::Concern

    included do
        belongs_to :prescription_category

        delegate :prescription_items, to: :prescription_category
        alias_attribute :items, :prescription_items

        validates :prescription_category, presence: true
    end
end
