puts 'RelationType'

Spree::RelationType.create!(name: 'similar_products', applies_to: 'Spree::Product')
Spree::RelationType.create!(name: 'recommended', applies_to: 'ContactLens')
