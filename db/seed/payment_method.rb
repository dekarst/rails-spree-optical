puts 'PaymentMethod'

# Spree::PaymentMethod::Check.create!(name: 'Offline Payment', active: true, environment: 'development')
# Spree::Gateway::AuthorizeNet.create!(name: 'Authorize.net', active: true, environment: 'development')
# Spree::Gateway::PayPal.create!(name: 'PayPal', active: true, environment: 'development')
# Spree::Gateway::Bogus.create!(name: 'Bogus', active: true, environment: 'development')

# TODO it seems Spree::PaymentMethod doesn't have environment attribute anymore. Check this.
#       All below classes inherit from it.

Spree::PaymentMethod::Check.create!(name: 'Offline Payment', active: true)
Spree::Gateway::AuthorizeNet.create!(name: 'Authorize.net', active: true)
Spree::Gateway::PayPalGateway.create!(name: 'PayPal', active: true)
Spree::Gateway::Bogus.create!(name: 'Bogus', active: true)
