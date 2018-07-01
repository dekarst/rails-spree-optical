puts '- Category'

taxonomy = Spree::Taxonomy.find_by_name!('Category')
# taxon = Spree::Taxon.find_by_name!('Category')
taxon = Spree::Taxon.joins(:translations).where(spree_taxon_translations: {name: 'Category'}).first

Spree::Taxon.create!(name: 'Eyeglasses', taxonomy: taxonomy, parent: taxon, position: 1)
Spree::Taxon.create!(name: 'Sunglasses', taxonomy: taxonomy, parent: taxon, position: 2)
Spree::Taxon.create!(name: 'Contact Lenses', taxonomy: taxonomy, parent: taxon, position: 3)
