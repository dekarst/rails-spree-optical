puts '- Manufacturer'

taxonomy = Spree::Taxonomy.find_by_name!('Manufacturer')
# taxon = Spree::Taxon.find_by_name!('Manufacturer')
taxon = Spree::Taxon.joins(:translations).where(spree_taxon_translations: {name: 'Manufacturer'}).first

Spree::Taxon.create!(name: 'Bausch & Lomb', taxonomy: taxonomy, parent: taxon, position: 1)
Spree::Taxon.create!(name: 'Ciba Vision', taxonomy: taxonomy, parent: taxon, position: 2)
Spree::Taxon.create!(name: 'Cooper Vision', taxonomy: taxonomy, parent: taxon, position: 3)
Spree::Taxon.create!(name: 'Johnson & Johnson', taxonomy: taxonomy, parent: taxon, position: 4)
Spree::Taxon.create!(name: 'Vistakon', taxonomy: taxonomy, parent: taxon, position: 5)
Spree::Taxon.create!(name: 'Hydrogel Vision', taxonomy: taxonomy, parent: taxon, position: 6)
Spree::Taxon.create!(name: 'Clearlab', taxonomy: taxonomy, parent: taxon, position: 7)
