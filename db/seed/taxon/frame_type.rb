puts '- Frame Type'

taxonomy = Spree::Taxonomy.find_by_name!('Frame Type')
# taxon = Spree::Taxon.find_by_name!('Frame Type')
taxon = Spree::Taxon.joins(:translations).where(spree_taxon_translations: {name: 'Frame Type'}).first

Spree::Taxon.create!(name: 'Full Rim', taxonomy: taxonomy, parent: taxon, position: 1)
Spree::Taxon.create!(name: 'Rimless', taxonomy: taxonomy, parent: taxon, position: 2)
Spree::Taxon.create!(name: 'Semi-Rimless', taxonomy: taxonomy, parent: taxon, position: 3)
