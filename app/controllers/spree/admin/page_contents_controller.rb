module Spree
    module Admin
        class PageContentsController < ResourceController
            def index
            end

            def model_class
                ::PageContent
            end
        end
    end
end

