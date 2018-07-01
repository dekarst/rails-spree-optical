module Spree
    module Core
        module ProductFilters
            Spree::Product.add_search_scope :any_taxon do |*taxon_ids|
                select("spree_products.id, spree_products.*").
                where(id: Classification.select('spree_products_taxons.product_id').
                    where('spree_products_taxons.taxon_id' => taxon_ids)
                )
            end

            if ActiveRecord::Base.connection.table_exists?('spree_taxonomies')
                Spree::Taxonomy.all.each do |taxonomy|
                    Spree::Product.add_search_scope "any_taxon_#{taxonomy.name.underscore}" do |*taxon_ids|
                        Spree::Product.any_taxon(*taxon_ids)
                    end
                end
            end

            def ProductFilters.filters(taxonomy, taxons)
                {
                    name:   taxonomy.name,
                    scope:  "any_taxon_#{taxonomy.name.underscore}",
                    labels: taxons.map {|t| [t.name, t.id]},
                    conds:  nil
                }
            end
        end
    end
end
