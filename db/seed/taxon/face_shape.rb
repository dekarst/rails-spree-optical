puts '- Face Shape'

taxonomy = Spree::Taxonomy.find_by_name!('Face Shape')
# taxon = Spree::Taxon.find_by_name!('Face Shape')
taxon = Spree::Taxon.joins(:translations).where(spree_taxon_translations: {name: 'Face Shape'}).first

Spree::Taxon.create!(name: 'Round', taxonomy: taxonomy, parent: taxon, position: 1)
Spree::Taxon.create!(name: 'Square', taxonomy: taxonomy, parent: taxon, position: 2)
Spree::Taxon.create!(name: 'Heart', taxonomy: taxonomy, parent: taxon, position: 3)
Spree::Taxon.create!(name: 'Oval', taxonomy: taxonomy, parent: taxon, position: 4)
