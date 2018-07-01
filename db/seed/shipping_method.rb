puts 'ShippingMethod'

shipping_method = Spree::ShippingMethod.create!({name: 'UPS Ground (USD)', zones: [Spree::Zone.last], calculator: Spree::Calculator::FlatRate.create!, shipping_categories: [Spree::ShippingCategory.first]})
shipping_method.calculator.preferred_amount = 5
shipping_method.calculator.preferred_currency = 'USD'
shipping_method.save!

shipping_method = Spree::ShippingMethod.create!({name: 'UPS Two Day (USD)', zones: [Spree::Zone.last], calculator: Spree::Calculator::FlatRate.create!, shipping_categories: [Spree::ShippingCategory.first]})
shipping_method.calculator.preferred_amount = 25
shipping_method.calculator.preferred_currency = 'USD'
shipping_method.save!

shipping_method = Spree::ShippingMethod.create!({name: 'UPS One Day (USD)', zones: [Spree::Zone.last], calculator: Spree::Calculator::FlatRate.create!, shipping_categories: [Spree::ShippingCategory.first]})
shipping_method.calculator.preferred_amount = 100
shipping_method.calculator.preferred_currency = 'USD'
shipping_method.save!

shipping_method = Spree::ShippingMethod.create!({name: 'UPS Ground (EUR)', zones: [Spree::Zone.first], calculator: Spree::Calculator::FlatRate.create!, shipping_categories: [Spree::ShippingCategory.first]})
shipping_method.calculator.preferred_amount = 10
shipping_method.calculator.preferred_currency = 'USD'
shipping_method.save!
