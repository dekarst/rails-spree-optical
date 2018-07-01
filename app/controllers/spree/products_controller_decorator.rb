Spree::ProductsController.class_eval do
    before_filter :load_order, only: :show
    before_filter :build_prescription_options, only: :show
    before_filter :find_model, only: [:thumbnails, :reviews]
    before_filter :load_sidebar_content, only: :index # FIXME DRY taxons_controller

    decorates_assigned :product

    def index
        @searcher = build_searcher(params)
        @products = @searcher.retrieve_products

        @products = @products.where("type != 'Lens' AND type != 'LensThicknessOption' AND type != 'LensProtectionOption' OR type IS NULL")
    end

    def thumbnails
        raise ActiveRecord::RecordNotFound if @product.nil?

        if @product.is_a?(Frame)
            @frame_color = FrameColor.find(params[:color_id])

            @product_thumbnails = @product.images + @product.images_from_color(@frame_color)
            @product_thumbnails.uniq!
        else
            @product_thumbnails = @product.images
        end

        render json: {html: render_to_string(partial: 'spree/products/thumbnails', layout: false, locals: {product: @product})}
    end

    def reviews
        raise ActiveRecord::RecordNotFound if @product.nil?
    end

    private
        def load_order
            @order = current_order(true)
        end

        def build_prescription_options
            if @product.is_a?(ContactLens)
                @prescription_options = {}
                @product.items.each do |item|
                    @prescription_options[item.name_to_display] = item.values.select {|v| @product.valid_value?(v)}
                end
            end
        end

        def load_sidebar_content
            sidebar = PageContent.find_by(slug: 'sidebar-page-content')

            @sidebar_page_content = sidebar.body if sidebar.present?
        end
end
