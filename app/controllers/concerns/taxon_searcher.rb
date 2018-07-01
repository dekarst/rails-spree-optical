module TaxonSearcher
    extend ActiveSupport::Concern

    included do
        before_filter :set_taxon_search
    end

    private
        def set_taxon_search
            @taxon_search ||= TaxonSearch.new
        end
end
