class ApplicationController < ActionController::Base
    include TaxonSearcher
    include ModelInitializer
    include Devisable
    include Spree::Core::ControllerHelpers::Order
    include Spree::Core::ControllerHelpers::Auth

    # TODO uncomment this line!!
    # before_filter :load_current_order
    before_filter :set_title
    before_filter :load_footer_content
    # before_action :set_locale

    protect_from_forgery with: :exception

    def set_locale
        I18n.locale = params[:locale] || I18n.default_locale
        Rails.application.routes.default_url_options[:locale] = I18n.locale
    end

    protected
        def title(page_title=nil)
            if page_title
                @title = "#{page_title} | #{@short_title}"
            end

            @title
        end
        helper_method :title

    private
        def load_current_order
            @order ||= current_order
        end

        def set_title
            @title = Spree::Config[:site_name]
            @short_title = Spree::Config[:short_site_name]
        end

        def load_footer_content
            footer = PageContent.find_by(slug: 'footer-page-content')
            copyright = PageContent.find_by(slug: 'copyright-page-content')

            @footer_page_content = footer.body if footer.present?
            @copyright_page_content = copyright.body if copyright.present?
        end

        def permitted_params(model_name=nil)
            model_name ||= controller_name.classify.underscore
            @permitted_params ||= PermittedParams.new(params, current_user).send(model_name)
        end
        helper_method :permitted_params
end
