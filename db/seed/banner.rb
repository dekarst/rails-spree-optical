puts 'Banner'

Spree::BannerBox.create!(category: 'product_page', attachment: File.open(Rails.root.join('doc', 'seed', 'banners', 'banner01.jpg')), enabled: true)
Spree::BannerBox.create!(category: 'product_page', attachment: File.open(Rails.root.join('doc', 'seed', 'banners', 'banner02.jpg')), enabled: true)
Spree::BannerBox.create!(category: 'product_page', attachment: File.open(Rails.root.join('doc', 'seed', 'banners', 'banner03.jpg')), enabled: true)
Spree::BannerBox.create!(category: 'vertical', attachment: File.open(Rails.root.join('doc', 'seed', 'banners', 'banner01.jpg')), enabled: true)
Spree::BannerBox.create!(category: 'vertical', attachment: File.open(Rails.root.join('doc', 'seed', 'banners', 'banner02.jpg')), enabled: true)
Spree::BannerBox.create!(category: 'bottom', attachment: File.open(Rails.root.join('doc', 'seed', 'banners', 'banner01.jpg')), enabled: true)
Spree::BannerBox.create!(category: 'bottom', attachment: File.open(Rails.root.join('doc', 'seed', 'banners', 'banner02.jpg')), enabled: true)
