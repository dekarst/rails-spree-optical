puts 'PrescriptionCategory'

prescription_categories = [
    {
        name: 'Prescription Options',
        prescription_items: [
            {name: 'Power', values: (25..900).step(25).map {|n| -n/100.0}+(25..400).step(25).map {|n| n/100.0}},
            {name: 'Base Curve (BC)', display_name: 'BC', values: [8.5]},
            {name: 'Diameter (DIA)', display_name: 'DIA', values: [14.5]},
            {name: 'Cylinder (CYL)', display_name: 'CYL', values: (0..400).step(25).map {|n| -n/100.0}},
            {name: 'Axis', values: (0..100).step(5).map {|n| "%02d" % n }},
        ],
    },
    {
        name: 'Cylindrical contacts (single vision)',
        prescription_items: [
            {name: 'Power', values: (50..600).step(25).map {|n| -n/100.0}},
            {name: 'Base Curve (BC)', display_name: 'BC', values: [8.4, 8.8]},
            {name: 'Diameter (DIA)', display_name: 'DIA', values: [14.0]},
        ],
    },
    {
        name: 'Toric contacts (Astigmatism)',
        prescription_items: [
            {name: 'Power', values: (25..900).step(25).map {|n| -n/100.0}+(25..400).step(25).map {|n| n/100.0}},
            {name: 'Cylinder (CYL)', display_name: 'CYL', values: [-0.75, -1.25, -1.75, -2.25]},
            {name: 'Axis', values: [10, 20, (60..120).step(10).to_a, 160, 170, 180].flatten},
            {name: 'Base Curve (BC)', display_name: 'BC', values: [8.5]},
            {name: 'Diameter (DIA)', display_name: 'DIA', values: [14.5]},
        ],
    },
    {
        name: 'Bi/multifocal',
        prescription_items: [
            {name: 'Power', values: ['None', 'Plano']+(25..800).step(25).map {|n| -n/100.0}+(25..600).step(25).map {|n| n/100.0}},
            {name: 'Base Curve (BC)', display_name: 'BC', values: [8.6]},
            {name: 'Diameter (DIA)', display_name: 'DIA', values: [14.0]},
            {name: 'Add', values: [2.5, 2, 1.5, 1]},
        ],
    },
    {
        name: 'Color/Tinted',
        prescription_items: [
            {name: 'Power', values: ['None', 'Plano']+(25..800).step(25).map {|n| -n/100.0}+(25..600).step(25).map {|n| n/100.0}},
            {name: 'Base Curve (BC)', display_name: 'BC', values: [8.6]},
            {name: 'Diameter (DIA)', display_name: 'DIA', values: [14.5]},
            {name: 'Color', values: ['Amethyst', 'Blue', 'Brilliant Blue', 'Gemstone Green', 'Gray', 'Green', 'Honey', 'Pure Hazel', 'Sterling Gray', 'True Sapphire', 'Turquoise']},
        ],
    },
]

prescription_categories.each do |prescription_category_attrs|
    prescription_items = prescription_category_attrs.delete(:prescription_items)

    prescription_category = PrescriptionCategory.create!(prescription_category_attrs)

    prescription_items.each do |prescription_item_attrs|
        values = prescription_item_attrs.delete(:values)

        prescription_item = PrescriptionItem.create!(prescription_item_attrs.merge(prescription_category: prescription_category))

        values.each do |value|
            PrescriptionValue.create!(name: value, prescription_item: prescription_item)
        end
    end
end
