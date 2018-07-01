puts '- Gender'

taxonomy = Spree::Taxonomy.find_by_name!('Gender')
# taxon = Spree::Taxon.find_by_name!('Gender')
taxon = Spree::Taxon.joins(:translations).where(spree_taxon_translations: {name: 'Gender'}).first

Spree::Taxon.create!(name: 'Male', taxonomy: taxonomy, parent: taxon, position: 1)
Spree::Taxon.create!(name: 'Female', taxonomy: taxonomy, parent: taxon, position: 2)
Spree::Taxon.create!(name: 'Children', taxonomy: taxonomy, parent: taxon, position: 3)
Spree::Taxon.create!(name: 'Unissex', taxonomy: taxonomy, parent: taxon, position: 4)
