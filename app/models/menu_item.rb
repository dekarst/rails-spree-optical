class MenuItem < ActiveRecord::Base
    belongs_to :menu
    belongs_to :menu_item
    belongs_to :page, class_name: 'Spree::Page'
    has_many :menu_items, dependent: :destroy

    alias_attribute :parent, :menu_item

    def link
        if link_to_page? and page.present?
            Rails.application.routes.named_routes[:spree].path.spec.to_s == '/' ? page.slug : Rails.application.routes.named_routes[:spree].path.spec.to_s + page.slug
        else
            url
        end
    end
end
