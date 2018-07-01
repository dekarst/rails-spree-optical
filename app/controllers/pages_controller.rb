class PagesController < ApplicationController
    def home
        home_content = PageContent.find_by(slug: 'home-page-content')
        @home_page_content = home_content.body if home_content.present?

        render layout: 'home'
    end
end
