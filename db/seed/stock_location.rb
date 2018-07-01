puts 'StockLocation'

location = Spree::StockLocation.create!(name: 'Default')
location.active = true
location.country = Spree::Country.where(iso: 'US').first
location.save!
