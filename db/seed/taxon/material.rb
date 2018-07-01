puts '- Material'

taxonomy = Spree::Taxonomy.find_by_name!('Material')
# taxon = Spree::Taxon.find_by_name!('Material')
taxon = Spree::Taxon.joins(:translations).where(spree_taxon_translations: {name: 'Material'}).first

Spree::Taxon.create!(name: 'Metal', taxonomy: taxonomy, parent: taxon, position: 1)
Spree::Taxon.create!(name: 'Plastic', taxonomy: taxonomy, parent: taxon, position: 2)
Spree::Taxon.create!(name: 'Titanium', taxonomy: taxonomy, parent: taxon, position: 3)
