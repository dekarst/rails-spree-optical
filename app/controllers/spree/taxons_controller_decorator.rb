Spree::TaxonsController.class_eval do
    before_filter :load_sidebar_content, only: :show

    decorates_assigned :products

    private
        def load_sidebar_content
            sidebar = PageContent.by_slug('sidebar-page-content').first

            @sidebar_page_content = sidebar.body if sidebar.present?
        end
end
