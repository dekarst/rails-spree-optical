puts '- LensType'

single_vision_lens_type = LensType.create!(name: 'Single Vision (Far/Close-up)')
bifocal_lens_type = LensType.create!(name: 'Bifocal (With Line)')
progressive_lens_type = LensType.create!(name: 'Progressive Lens (No Line)')

puts '- Lens'

default_attrs = {
    available_on: Time.zone.now,
    tax_category: Spree::TaxCategory.find_by_name!('Lenses'),
    prescription_category: PrescriptionCategory.first,
}

lenses = [
    {
        name: 'Single Vision (Far/Close-up) Standard',
        price: 43.46,
        image: 'single-vision.jpg',
        lens_type: single_vision_lens_type,
        rules: [
            {prescription_item_id: 1, operation: '>=', value: '0.25', complementary_operation: '<', complementary_value: '5'},
            {prescription_item_id: 2, operation: '=', value: '8.5'},
            {prescription_item_id: 4, operation: '=', value: '-0.75'},
            {prescription_item_id: 4, operation: '=', value: '-1.25'},
            {prescription_item_id: 5, operation: '<', value: '100'},
        ],
        lens_thickness_ids: [1, 2, 3],
        lens_protection_ids: [1, 2, 3, 4],
    },
    {
        name: 'Single Vision (Far/Close-up) Preimum',
        price: 43.46,
        image: 'single-vision.jpg',
        lens_type: single_vision_lens_type,
        rules: [
            {prescription_item_id: 1, operation: '>=', value: '0.25', complementary_operation: '<', complementary_value: '5'},
            {prescription_item_id: 2, operation: '=', value: '8.5'},
            {prescription_item_id: 4, operation: '=', value: '-0.75'},
            {prescription_item_id: 4, operation: '=', value: '-1.25'},
            {prescription_item_id: 5, operation: '<', value: '100'},
        ],
        lens_thickness_ids: [1, 2, 3],
        lens_protection_ids: [1, 2, 3, 4],
    },
    {
        name: 'Bifocal (With Line) Standard',
        price: 72.44,
        image: 'bifocal.jpg',
        lens_type: bifocal_lens_type,
        lens_thickness_ids: [1, 2, 3],
        lens_protection_ids: [1, 2],
    },
    {
        name: 'Bifocal (With Line) Preimum',
        price: 72.44,
        image: 'bifocal.jpg',
        lens_type: bifocal_lens_type,
        lens_thickness_ids: [1, 2, 3],
        lens_protection_ids: [1, 2],
    },
    {
        name: 'Progressive Lens (No Line) Standard',
        price: 230.86,
        image: 'progressive-lens.jpg',
        lens_type: progressive_lens_type,
        lens_thickness_ids: [1, 2],
        lens_protection_ids: [1, 2, 3, 4],
    },
    {
        name: 'Progressive Lens (No Line) Preimum',
        price: 230.86,
        image: 'progressive-lens.jpg',
        lens_type: progressive_lens_type,
        lens_thickness_ids: [1, 2],
        lens_protection_ids: [1, 2, 3, 4],
    },
]

lenses.each do |lens_attrs|
    attrs = default_attrs.merge(lens_attrs)

    image = attrs.delete(:image)
    rules = attrs.delete(:rules)

    lens = Lens.create!(attrs)

    Spree::Taxon.find_or_create_by(name: 'Lenses', taxonomy: Spree::Taxonomy.find_by(name: 'Category')).products << lens

    lens.master.images.create!({attachment: File.open(Rails.root.join('doc', 'seed', 'lenses', image))}) if image

    rules ||= []
    rules.each do |rule_attrs|
        lens.rules.create!(rule_attrs)
    end
end
