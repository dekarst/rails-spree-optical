Spree::Core::Engine.load_seed if defined?(Spree::Core)
Spree::Auth::Engine.load_seed if defined?(Spree::Auth)

require Rails.root.join('db', 'seed', 'spree_config')

require Rails.root.join('db', 'seed', 'tax_category')
require Rails.root.join('db', 'seed', 'shipping_method')
require Rails.root.join('db', 'seed', 'stock_location')
require Rails.root.join('db', 'seed', 'payment_method')
require Rails.root.join('db', 'seed', 'relation_type')

require Rails.root.join('db', 'seed', 'taxonomy')
require Rails.root.join('db', 'seed', 'taxon')
require Rails.root.join('db', 'seed', 'option_type')
require Rails.root.join('db', 'seed', 'property')
require Rails.root.join('db', 'seed', 'prototype')

require Rails.root.join('db', 'seed', 'prescription_category')
require Rails.root.join('db', 'seed', 'lens_thickness')
require Rails.root.join('db', 'seed', 'lens_protection')
require Rails.root.join('db', 'seed', 'brand')
require Rails.root.join('db', 'seed', 'face_shape')

require Rails.root.join('db', 'seed', 'product')
require Rails.root.join('db', 'seed', 'page_content')
require Rails.root.join('db', 'seed', 'page')
require Rails.root.join('db', 'seed', 'menu')
# require Rails.root.join('db', 'seed', 'banner')
require Rails.root.join('db', 'seed', 'user')
