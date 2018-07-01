class PageContent < Spree::Page
    before_validation :set_slug, on: :create
    before_save :dont_display
    before_update :dont_change_title_and_slug

    model_name.class_eval do
        def route_key
            'pages'
        end

        def singular_route_key
            'page'
        end
    end

    private
        def set_slug
            self.slug = "#{title.parameterize}-page-content" if title.present?
        end

        def dont_display
            self.show_in_header = false
            self.show_in_footer = false
            self.show_in_sidebar = false
            self.visible = false

            return true
        end

        def dont_change_title_and_slug
            self.title = title_was if title_changed?
            self.slug = slug_was if slug_changed?

            return true
        end
end
