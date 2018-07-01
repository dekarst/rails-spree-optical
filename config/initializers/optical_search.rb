require Rails.root.join('lib', 'spree', 'optical_search.rb')

Spree::Config.searcher_class = Spree::OpticalSearch
