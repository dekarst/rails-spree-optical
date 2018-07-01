puts 'Prototype'

Spree::Prototype.create!(name: 'FramePrototype',
    properties: [
        Spree::Property.find_or_create_by!(name: 'material'),
    ],
    option_types: [
        Spree::OptionType.find_or_create_by!(name: 'eye'),
        Spree::OptionType.find_or_create_by!(name: 'bridge'),
        Spree::OptionType.find_or_create_by!(name: 'temple'),
        Spree::OptionType.find_or_create_by!(name: 'b'),
        Spree::OptionType.find_or_create_by!(name: 'progressive-friendly'),
    ],
)
