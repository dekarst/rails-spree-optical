module LensHelper
    def select_prescription_text
        content = PageContent.by_slug('select-prescription-text-page-content').first

        content.present? ? content.body : ''
    end
end
