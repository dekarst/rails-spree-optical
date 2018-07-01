puts '- Frame'

default_attrs = {
    description: Faker::Lorem.paragraph,
    available_on: Time.zone.now,
    tax_category: Spree::TaxCategory.find_by_name!('Frames'),
}

frames = [
    {
        # http://www.framesdirect.com/framesfp/RayBan-sdpes/lb.html
        name: 'Ray-Ban RB3025 Large Metal Aviator Sunglasses',
        brand: 'Ray-Ban',
        gender: 'Male',
        material: 'Metal',
        price: 121.38, retail_price: 153.38,
        image: 'ray-ban/RB3025',
        lenses: Lens.all,
        shapes: [FaceShape.first],
        variants: [
            {
                color: 'Black / Crystal Green Lens (L2823)',
                eye: 58, bridge: 14, temple: 135, b: 'yes', :'progressive-friendly' => 'yes',
                basic_colors: ['Black', 'Green'],
                image: 'L2823',
            },
            {
                color: 'Arista / Crystal Green Polarized Lens (001/58)',
                price: 144.29, retail_price: 184.80,
                eye: 55, bridge: 14, temple: 135, b: 'yes', :'progressive-friendly' => 'no',
                basic_colors: ['Arista', 'Green'],
                image: '00158',
            },
            {
                color: 'Arista / Crystal Green Polarized Lens (001/58)',
                price: 144.29, retail_price: 184.80,
                eye: 58, bridge: 14, temple: 135, b: 'no', :'progressive-friendly' => 'no',
                basic_colors: ['Arista', 'Green'],
            },
            {
                color: 'Arista / Crystal Green Polarized Lens (001/58)',
                price: 144.29, retail_price: 184.80,
                eye: 62, bridge: 14, temple: 140,
                basic_colors: ['Arista', 'Green'],
            },
            {
                color: 'Gunmetal / Crystal Polarized Blue Grad. Pink Lens (004/77)',
                price: 147.84, retail_price: 189.54,
                eye: 55, bridge: 14, temple: 135,
                basic_colors: ['Blue', 'Pink'],
                image: '00477',
            },
            {
                color: 'Gunmetal / Crystal Polarized Blue Grad. Pink Lens (004/77)',
                price: 147.84, retail_price: 189.54,
                eye: 58, bridge: 14, temple: 135,
                basic_colors: ['Blue', 'Pink'],
            },
        ]
    },
    {
        # http://www.framesdirect.com/framesfp/RayBan-tcqaoi/lb.html
        name: 'Ray-Ban RB2140 Original Wayfarer Sunglasses',
        brand: 'Ray-Ban',
        gender: 'Unissex',
        material: 'Acetate',
        price: 112.30, retail_price: 142.16,
        image: 'ray-ban/RB2140',
        lenses: [Lens.all[0], Lens.all[1], Lens.all[2], Lens.all[3]],
        variants: [
            {
                color: 'Black / Crystal Green Lens (901)',
                eye: 50, bridge: 22, temple: 150,
                basic_colors: ['Black', 'Green'],
                image: '901',
            },
            {
                color: 'Black / Crystal Green Lens (901)',
                eye: 54, bridge: 18, temple: 150,
                basic_colors: ['Black', 'Green'],
                image: '901',
            },
            {
                color: 'Tortoise / Crystal Brown Polarized Lens (902/57)',
                price: 147.84, retail_price: 189.54,
                eye: 50, bridge: 22, temple: 150,
                basic_colors: ['Tortoise', 'Brown'],
                image: '90257',
            },
            {
                color: 'Tortoise / Crystal Brown Polarized Lens (902/57)',
                price: 147.84, retail_price: 189.54,
                eye: 54, bridge: 18, temple: 150,
                basic_colors: ['Tortoise', 'Brown'],
                image: '90257',
            },
        ]
    },
]

frames.each do |frame_attrs|
    attrs = default_attrs.merge(frame_attrs)

    image = attrs.delete(:image)
    brand = attrs.delete(:brand)
    gender = attrs.delete(:gender)
    material = attrs.delete(:material)
    variants = attrs.delete(:variants)
    lenses = attrs.delete(:lenses)

    frame = Frame.create!(attrs)

    frame.set_property('Material', material) if material

    Spree::Taxon.find_or_create_by(name: 'Sunglasses', taxonomy: Spree::Taxonomy.find_by(name: 'Category')).products << frame
    Spree::Taxon.find_or_create_by(name: brand, taxonomy: Spree::Taxonomy.find_by(name: 'Brand')).products << frame
    Spree::Taxon.find_or_create_by(name: gender, taxonomy: Spree::Taxonomy.find_by(name: 'Gender')).products << frame

    if lenses
        lenses.each do |lens|
            frame.frame_lens_associations.create!(lens: lens)
        end
    end

    if variants
        variants.each do |variant_attrs|
            color_name = variant_attrs[:color]
            color = FrameColor.find_or_create_by!(name: color_name, frame: frame)

            variant = frame.variants.create!(price: variant_attrs[:price], retail_price: variant_attrs[:retail_price], frame_color: color)

            ['eye', 'bridge', 'temple', 'b', 'progressive-friendly'].each do |ot|
                variant.set_option_value(ot, variant_attrs[ot.to_sym]) if variant_attrs[ot.to_sym]
            end

            basic_colors = variant_attrs[:basic_colors]
            if basic_colors
                basic_colors.each do |basic_color|
                    begin
                        Spree::Taxon.find_or_create_by!(name: basic_color, taxonomy: Spree::Taxonomy.find_by(name: 'Color')).products << frame
                    rescue
                    end
                end
            end

            variant_image = variant_attrs[:image]

            # 263 x 205
            if image and variant_image
                Dir.glob Rails.root.join('doc', 'seed', 'frames', image, variant_image, '*') do |file|
                    variant.images.create!({attachment: File.open(file)})
                end
            end

            Spree::StockMovement.create!(stock_item: variant.stock_items.first, quantity: 10)
        end
    end
end
