Spree::Taxon.class_eval do
    def applicable_filters
        filters = []

        Spree::Taxonomy.where('id != :taxonomy_id', {taxonomy_id: taxonomy_id}).order(:id).each do |taxonomy|
            root_taxon = taxonomy.root

            taxons = if root_taxon.descendants.map {|d| d.depth}.max > 1
                taxon = root_taxon.descendants.find_by(depth: 1, name: self.name)
                taxon.try(:descendants) || []
            else
                root_taxon.descendants
            end

            if taxons.any?
                filters << Spree::Core::ProductFilters.filters(taxonomy, taxons.sort_by(&:position))
            end
        end

        filters
    end
end
