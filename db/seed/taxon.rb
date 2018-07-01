puts 'Taxon'

Dir.glob(Rails.root.join('db', 'seed', 'taxon', '*'), &method(:require))
