# Configure Spree Preferences
#
# Note: Initializing preferences available within the Admin will overwrite any changes that were made through the user interface when you restart.
#       If you would like users to be able to update a setting with the Admin it should NOT be set here.
#
# Note: If a preference is set here it will be stored within the cache & database upon initialization.
#       Just removing an entry from this initializer will not make the preference value go away.
#       Instead you must either set a new value or remove entry, clear cache, and remove database entry.
#

Spree::AppConfiguration.class_eval do
    preference :site_name, :string
    preference :short_site_name, :string
end

Spree.config do |config|
    config.layout = 'application'
    config.admin_interface_logo = '/images/logo.png'
    # config.allow_ssl_in_production = false
    config.allow_guest_checkout = false
    # config.enable_mail_delivery = true
    # config.override_actionmailer_config = true
end

# Spree.user_class = 'User'
Spree.user_class = 'Spree::LegacyUser'

SpreeI18n::Config.available_locales = [:en, :es, :fr] # displayed on translation forms
SpreeI18n::Config.supported_locales = [:en, :es, :fr] # displayed on frontend select box

Rails.application.config.to_prepare do
    require_dependency 'spree/authentication_helpers'
    require_dependency 'spree/product_filters'
end

if defined?(Sass)
    backend_admin_assets_path = File.join(Spree::Backend::Engine.root, 'app', 'assets', 'stylesheets', 'admin')
    Sass.load_paths << backend_admin_assets_path
    Sass.load_paths.concat Rails.configuration.assets[:paths]
end

# # Rails.application.config.spree.promotions.rules << RolesPromotionRule
