puts '- Type'

taxonomy = Spree::Taxonomy.find_by_name!('Type')
# taxon = Spree::Taxon.find_by_name!('Type')
taxon = Spree::Taxon.joins(:translations).where(spree_taxon_translations: {name: 'Type'}).first

Spree::Taxon.create!(name: 'Daily Disposable', taxonomy: taxonomy, parent: taxon, position: 1)
Spree::Taxon.create!(name: '1-2 Week Disposable', taxonomy: taxonomy, parent: taxon, position: 2)
Spree::Taxon.create!(name: '1-3 Month Disposable', taxonomy: taxonomy, parent: taxon, position: 3)
Spree::Taxon.create!(name: 'Conventional (vial)', taxonomy: taxonomy, parent: taxon, position: 4)
Spree::Taxon.create!(name: 'Toric', taxonomy: taxonomy, parent: taxon, position: 5)
Spree::Taxon.create!(name: 'RGP (Oxygen Permeable)', taxonomy: taxonomy, parent: taxon, position: 6)
Spree::Taxon.create!(name: 'Colored and Tinted', taxonomy: taxonomy, parent: taxon, position: 7)
Spree::Taxon.create!(name: 'BiFocal', taxonomy: taxonomy, parent: taxon, position: 8)
Spree::Taxon.create!(name: 'Special Effect', taxonomy: taxonomy, parent: taxon, position: 9)
Spree::Taxon.create!(name: 'Sports Contacts', taxonomy: taxonomy, parent: taxon, position: 10)
Spree::Taxon.create!(name: 'Cosmetic Contact', taxonomy: taxonomy, parent: taxon, position: 11)
