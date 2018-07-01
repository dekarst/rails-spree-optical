puts 'OptionType'

option_types = [
    {name: 'eye', presentation: 'Eye'},
    {name: 'bridge', presentation: 'Bridge'},
    {name: 'temple', presentation: 'Temple'},
    {name: 'b', presentation: 'B'},
    {name: 'progressive-friendly', presentation: 'Progressive-Friendly'},
]

option_types.each do |option_type_attrs|
    Spree::OptionType.create(option_type_attrs)
end
