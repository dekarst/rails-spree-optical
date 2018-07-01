require File.expand_path('../boot', __FILE__)

require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "sprockets/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Optical
    class Application < Rails::Application
        # Settings in config/environments/* take precedence over those specified here.
        # Application configuration should go into files in config/initializers
        # -- all .rb files in that directory are automatically loaded.

        # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
        # config.i18n.default_locale = :en

        # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
        # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
        # config.time_zone = 'Central Time (US & Canada)'

        config.autoload_paths += Dir[Rails.root.join('app', 'models', '{**}')]

        config.active_record.observers = [:contact_observer]

        config.to_prepare do
            Dir.glob(File.join(File.dirname(__FILE__), "../app/**/*_decorator*.rb")) do |c|
                Rails.configuration.cache_classes ? require(c) : load(c)
            end

            Dir.glob(File.join(File.dirname(__FILE__), "../app/overrides/*.rb")) do |c|
                Rails.configuration.cache_classes ? require(c) : load(c)
            end
        end

        config.assets.precompile << Proc.new do |path|
            if path =~ /\.(css|js)\z/
                full_path = Rails.application.assets.resolve(path).to_path
                app_assets_path = Rails.root.join('app', 'assets').to_path
                if full_path.starts_with? app_assets_path
                    puts "including asset: " + full_path
                    true
                else
                    puts "excluding asset: " + full_path
                    false
                end
            else
                false
            end
        end

        config.less.paths << "#{Rails.root}/assets/stylesheets/less"
        config.less.compress = true

        config.generators.stylesheets = false
        config.generators.javascripts = false

        config.i18n.enforce_available_locales = true
        config.active_record.raise_in_transactional_callbacks = true

        # config.generators do |g|
        #     g.test_framework :rspec,
        #         fixtures: true,
        #         view_specs: false,
        #         helper_specs: false,
        #         routing_specs: false,
        #         controller_specs: true,
        #         request_specs: true
        #     g.fixture_replacement :factory_girl, dir: 'spec/factories'
        # end
    end
end
