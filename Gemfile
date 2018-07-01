source 'http://rubygems.org'

ruby '2.0.0'

gem 'rails', '4.2.2'

# gem 'mysql2'
# gem 'sass-rails', '~> 4.2.0'
# gem 'uglifier', '>= 1.3.0'
# gem 'coffee-rails', '~> 4.2.0'
# gem 'jquery-rails'
# gem 'jbuilder', '~> 1.2'
# gem 'therubyracer', platforms: :ruby
# gem 'less-rails'
# gem 'less-rails-bootstrap'
# gem 'less-rails-fontawesome'

gem 'mysql2'
gem 'jquery-rails', '~> 4.0'
gem 'twitter-bootstrap-rails'
gem 'bootstrap-wysihtml5-rails'
gem 'less-rails'
gem 'jquery-ui-rails'
gem 'sass-rails', '~> 4.0.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'therubyracer', platforms: :ruby
gem 'uglifier', '>= 1.3.0'
gem 'activerecord-session_store', github: 'rails/activerecord-session_store'

gem 'simple_form'
gem 'devise'
gem 'cancan'
gem 'nested_form'
gem 'kaminari'
gem 'gon'
# TODO check the changes (commits) I did to see why I was using a custom gem
#        I think it can be safely replaced by the original draper gem
gem 'draper', github: 'ricardokrieg/draper'
gem 'rails-observers'
gem 'messengerjs-rails'
gem 'rmagick'
gem 'mini_magick'
gem 'randumb'
gem 'carrierwave'
gem 'headless'
#33{CKeditor on Content}
gem 'ckeditor', github: 'galetahub/ckeditor'
gem 'letsrate', github: 'muratguzel/letsrate'
gem 'globalize'
gem 'select2-rails'
gem 'ffaker'
gem 'responders', '~> 2.0'
gem 'rollbar', '~> 1.2.11'

gem 'spree', github: 'spree/spree', branch: '3-0-stable'
gem 'spree_auth_devise', github: 'spree/spree_auth_devise', branch: '3-0-stable'
gem 'spree_gateway', github: 'spree/spree_gateway', branch: '3-0-stable'
# #127{MultiLanguage}
gem 'spree_i18n', github: 'spree-contrib/spree_i18n', branch: '3-0-stable'

# Spree Extensions

gem 'spree_multi_currency', github: 'spree-contrib/spree_multi_currency', branch: '3-0-stable'
gem 'spree_static_content', github: 'spree-contrib/spree_static_content', branch: '3-0-stable'
gem 'spree_mail_settings', github: 'spree-contrib/spree_mail_settings', branch: '3-0-stable'
gem 'spree_related_products', github: 'spree-contrib/spree_related_products', branch: '3-0-stable'

# TODO check the changes (commits) I did to see why I was using a custom gem
# gem 'spree_banner', github: 'ricardokrieg/spree_banner', branch: 'master'
gem 'spree_banner', github: 'damianogiacomello/spree_banner', branch: 'master'

# gem 'spree_editor', github: 'ricardokrieg/spree_editor', branch: '2-1-stable'
# gem 'spree_social_products', github: 'ricardokrieg/spree_social_products'
# #183{Email to Friend View}
# gem 'spree_email_to_friend', github: 'ricardokrieg/spree_email_to_friend', branch: 'master'


# #199{User Groups & Permissions}
# gem 'spree_admin_roles_and_access'

# #198{credit}
# gem 'spree_wallet', '2.1.0'
# #149{Coupon Code}
# gem 'spree_gift_card', github: 'jdutil/spree_gift_card', branch: '2-1-stable'
# #126{MultiCurrency}
# gem 'spree_paypal_express', github: 'spree-contrib/better_spree_paypal_express', branch: '2-1-stable'
# #132{Home content}
# gem 'spree_multi_slideshow'
# #90{User Settings}
# gem 'spree_recently_viewed', github: 'spree-contrib/spree_recently_viewed', branch: '2-1-stable'
# #200{Promotions in admin & Front - End}
# gem 'spree_promotion_roles_rule', github: 'traels/spree-promotion-roles-rule', branch: '2-1-stable'
# #58{Fix Select Shipping Method Page}
# gem 'spree_active_shipping', github: 'spree/spree_active_shipping', branch: '2-1-stable'
# #84{Contact Us}
# gem 'spree_contact_us', github: 'jdutil/spree_contact_us', branch: '2-1-stable'

group :development do
    gem 'capistrano', '~> 3.2.1'
    gem 'capistrano-rails', '~> 1.1'
    gem 'capistrano-bundler', '~> 1.1'
    gem 'capistrano-unicorn-nginx', '~> 3.2.0'
    gem 'capistrano-rvm', '~> 0.1'
    # gem 'capistrano-maintenance', github: 'capistrano/maintenance'
    gem 'rails-erd'
    gem 'brakeman'
    gem 'better_errors'
    gem 'binding_of_caller'
    gem 'bullet'
    gem 'flay'
    gem 'hirb'
    gem 'lol_dba'
    gem 'meta_request'
    gem 'pry'
    gem 'quiet_assets'
    gem 'rails_best_practices'
    gem 'reek'
    gem 'request-log-analyzer'
    gem 'smusher'
    gem 'byebug'
end

# group :development, :test do
#     gem 'rspec-rails'
#     gem 'factory_girl_rails'
#     gem 'capybara'
#     gem 'selenium-webdriver'
#     gem 'rack_session_access'
#     gem 'launchy'
# end

# group :test do
#     gem 'database_cleaner'
# end

group :production do
    gem 'unicorn'
end
