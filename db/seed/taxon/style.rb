puts '- Style'

taxonomy = Spree::Taxonomy.find_by_name!('Style')
# taxon = Spree::Taxon.find_by_name!('Style')
taxon = Spree::Taxon.joins(:translations).where(spree_taxon_translations: {name: 'Style'}).first

Spree::Taxon.create!(name: 'Classic', taxonomy: taxonomy, parent: taxon, position: 1)
Spree::Taxon.create!(name: 'Eyewear Art', taxonomy: taxonomy, parent: taxon, position: 2)
Spree::Taxon.create!(name: 'Modern', taxonomy: taxonomy, parent: taxon, position: 3)
Spree::Taxon.create!(name: 'Retro', taxonomy: taxonomy, parent: taxon, position: 4)
Spree::Taxon.create!(name: 'Retro Femme', taxonomy: taxonomy, parent: taxon, position: 5)
Spree::Taxon.create!(name: 'Trendy', taxonomy: taxonomy, parent: taxon, position: 6)
