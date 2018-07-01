puts '- Color'

taxonomy = Spree::Taxonomy.find_by_name!('Color')
# taxon = Spree::Taxon.find_by_name!('Color')
taxon = Spree::Taxon.joins(:translations).where(spree_taxon_translations: {name: 'Color'}).first

Spree::Taxon.create!(name: 'Black', taxonomy: taxonomy, parent: taxon, position: 1)
Spree::Taxon.create!(name: 'Blue', taxonomy: taxonomy, parent: taxon, position: 2)
Spree::Taxon.create!(name: 'Brown', taxonomy: taxonomy, parent: taxon, position: 3)
Spree::Taxon.create!(name: 'Clear', taxonomy: taxonomy, parent: taxon, position: 4)
Spree::Taxon.create!(name: 'Cream', taxonomy: taxonomy, parent: taxon, position: 5)
Spree::Taxon.create!(name: 'Gold', taxonomy: taxonomy, parent: taxon, position: 6)
Spree::Taxon.create!(name: 'Green', taxonomy: taxonomy, parent: taxon, position: 7)
Spree::Taxon.create!(name: 'Grey', taxonomy: taxonomy, parent: taxon, position: 8)
Spree::Taxon.create!(name: 'Grunmetal', taxonomy: taxonomy, parent: taxon, position: 9)
Spree::Taxon.create!(name: 'Mixed', taxonomy: taxonomy, parent: taxon, position: 10)
Spree::Taxon.create!(name: 'Orange', taxonomy: taxonomy, parent: taxon, position: 11)
Spree::Taxon.create!(name: 'Pink', taxonomy: taxonomy, parent: taxon, position: 12)
Spree::Taxon.create!(name: 'Purple', taxonomy: taxonomy, parent: taxon, position: 13)
Spree::Taxon.create!(name: 'Red', taxonomy: taxonomy, parent: taxon, position: 14)
Spree::Taxon.create!(name: 'Silver', taxonomy: taxonomy, parent: taxon, position: 15)
Spree::Taxon.create!(name: 'Tortoise', taxonomy: taxonomy, parent: taxon, position: 16)
Spree::Taxon.create!(name: 'White', taxonomy: taxonomy, parent: taxon, position: 17)
Spree::Taxon.create!(name: 'Yellow', taxonomy: taxonomy, parent: taxon, position: 18)
