RSpec.configure do |config|
    config.before(:each) do
        # Taxonomy
        Spree::Taxonomy.create!(name: 'Category')
        Spree::Taxonomy.create!(name: 'Brand')
        Spree::Taxonomy.create!(name: 'Gender')
        Spree::Taxonomy.create!(name: 'Color')
        Spree::Taxonomy.create!(name: 'Frame Type')
        Spree::Taxonomy.create!(name: 'Frame Shape')
        Spree::Taxonomy.create!(name: 'Material')
        Spree::Taxonomy.create!(name: 'Face Shape')
        Spree::Taxonomy.create!(name: 'Style')
        Spree::Taxonomy.create!(name: 'Type')
        Spree::Taxonomy.create!(name: 'Manufacturer')

        # Taxon
        Spree::Taxon.create!(name: 'Contact Lenses', taxonomy_id: 1, parent: nil, position: 0)

        # TaxCategory
        Spree::TaxCategory.create!(name: 'Contact Lenses')

        # ShippingCategory
        shipping_category = Spree::ShippingCategory.create!(name: 'Default Shipping')

        # Country
        country = Spree::Country.create!({name: 'United States', iso3: 'USA', iso: 'US', iso_name: 'UNITED STATES', numcode: '840'})

        # State
        Spree::State.create!({name: 'Nevada', abbr: 'NV', country: country})

        # Zone
        zone = Spree::Zone.create!(name: 'North America', description: 'USA')
        zone.zone_members.create!(zoneable: country)

        # StockLocation
        Spree::StockLocation.create!(name: 'Default Stock Location')

        # ShippingMethod
        shipping_method = Spree::ShippingMethod.create!({name: 'UPS Ground (USD)', zones: [zone], calculator: Spree::Calculator::FlatRate.create!, shipping_categories: [shipping_category]})
        shipping_method.calculator.preferred_amount = 5
        shipping_method.calculator.preferred_currency = 'USD'
        shipping_method.save!

        # PaymentMethod
        payment_method = Spree::Gateway::Bogus.create!(name: 'Bogus', active: true, environment: 'test', display_on: '')
    end
end
