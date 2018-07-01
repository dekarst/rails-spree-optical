puts 'Brand'

Brand.create!(name: 'Lacoste', image: File.open(Rails.root.join('doc', 'seed', 'brands', 'lacoste.png')), url: '/t/brand/sunglasses/lacoste', position: 1)
Brand.create!(name: 'Burberry', image: File.open(Rails.root.join('doc', 'seed', 'brands', 'burberry.png')), url: '/t/brand/sunglasses/burberry', position: 3)
Brand.create!(name: 'Ray-Ban', image: File.open(Rails.root.join('doc', 'seed', 'brands', 'ray-ban.png')), url: '/t/brand/sunglasses/ray-ban', position: 0)
Brand.create!(name: 'Kate-Spade', image: File.open(Rails.root.join('doc', 'seed', 'brands', 'kate-spade.png')), url: '/t/brand/sunglasses/kate-spade', position: 2)
