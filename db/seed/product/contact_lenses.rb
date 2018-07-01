puts '- Contact Lens'

default_attrs = {
    description: Faker::Lorem.paragraph,
    available_on: Time.zone.now,
    type: 'Conventional',
    prescription_category_id: 1,
}

contact_lenses = [
    {
        # http://www.framesdirect.com/Acuvue-contact-lenses-cp-ni/tjs.html
        name: 'Acuvue',
        brand: 'Acuvue',
        manufacturer: 'Johnson & Johnson',
        material: '58% water content - etifilcon A. Visibility tint.',
        price: '22.95',
        images: ['acuvue-01.jpg'],
    },
    {
        # http://www.framesdirect.com/Acuvue-1-Day-30-pack-contact-lenses-cp-ni/thk.html
        name: 'Acuvue 1 Day 30 pack',
        brand: 'Acuvue',
        type: 'Daily Disposable',
        manufacturer: 'Johnson & Johnson',
        material: '58% water content - etifilcon A. Visibility tint.',
        price: '28.75',
        images: ['acuvue-02.jpg'],
    },
    {
        # http://www.framesdirect.com/Acuvue-1-Day-Moist-30-PACK-contact-lenses-cp-ni/thk.html
        name: 'Acuvue 1 Day Moist 30 PACK',
        brand: 'Acuvue',
        type: 'Daily Disposable',
        manufacturer: 'Johnson & Johnson',
        price: '28.50',
        images: ['acuvue-03.jpg'],
    },
    {
        # http://www.framesdirect.com/Acuvue-1-Day-Moist-for-Astigmatism-contact-lenses-cp-ni/pakcmal.html
        name: 'Acuvue 1 Day Moist for Astigmatism',
        brand: 'Acuvue',
        type: 'Toric',
        manufacturer: 'Vistakon',
        price: '29.99',
        images: ['acuvue-04.jpg'],
        prescription_category_id: 2,
    },
    {
        # http://www.framesdirect.com/Acuvue-2-Colours-Enhancer-contact-lenses-cp-ni/tiq.html
        name: 'Acuvue 2 Colours Enhancer',
        brand: 'Acuvue',
        type: 'Colored and Tinted',
        manufacturer: 'Johnson & Johnson',
        material: '58% water content - etifilcon A.',
        price: '32.74',
        images: ['acuvue-05.jpg'],
        prescription_category_id: 4,
    },
    {
        # http://www.framesdirect.com/Acuvue-Advance-contact-lenses-cp-ni/tio.html
        name: 'Acuvue Advance',
        brand: 'Acuvue',
        manufacturer: 'Johnson & Johnson',
        material: '47% water content - galyfilcon A. Visibility tint.',
        price: '22.99',
        images: ['acuvue-06.jpg'],
    },
    {
        # http://www.framesdirect.com/Acuvue-Bifocals-contact-lenses-cp-ni/lakj.html
        name: 'Acuvue Bifocals',
        brand: 'Acuvue',
        type: 'BiFocal',
        manufacturer: 'Johnson & Johnson',
        material: '58% water content - etafilcon A. Visibility Tint.',
        price: '33.75',
        images: ['acuvue-07.jpg'],
        prescription_category_id: 3,
    },
    {
        # http://www.framesdirect.com/Biofinity-contact-lenses-cp-ni/ldpi.html
        name: 'Biofinity',
        brand: 'Biofinity',
        manufacturer: 'Cooper Vision',
        price: '34.99',
        images: ['biofinity-01.jpg'],
    },
    {
        # http://www.framesdirect.com/Biofinity-Multi-Focal-contact-lenses-cp-ni/lfnapgp.html
        name: 'Biofinity Multi-Focal',
        brand: 'Biofinity',
        type: 'BiFocal',
        manufacturer: 'Cooper Vision',
        material: 'Comfilcon A - 48% water content',
        price: '64.99',
        images: ['biofinity-02.jpg'],
        prescription_category_id: 3,
    },
    {
        # http://www.framesdirect.com/Biofinity-Toric-contact-lenses-cp-ni/k.html
        name: 'Biofinity Toric',
        brand: 'Biofinity',
        type: 'Toric',
        manufacturer: 'Cooper Vision',
        material: 'Comfilcon A - 48% water content',
        price: '53.99',
        images: ['biofinity-03.jpg'],
        prescription_category_id: 2,
    },
    {
        # http://www.framesdirect.com/Dailies-AquaComfort-Plus-30Pk-contact-lenses-cp-ni/ldrh.html
        name: 'Dailies AquaComfort Plus 30 Pk',
        brand: 'Dailies',
        manufacturer: 'Ciba',
        price: '24.75',
        images: ['dailies-01.jpg'],
    },
    {
        # http://www.framesdirect.com/Dailies-AquaComfort-Plus-30Pk-contact-lenses-cp-ni/ldrh.html
        name: 'SofLens 38',
        brand: 'SofLens',
        manufacturer: 'Bausch & Lomb',
        material: '38.6% water content - polymacon. Visibility tint.',
        price: '18.75',
        images: ['soflens-01.jpg'],
    },
    {
        # http://www.framesdirect.com/SofLens-One-Day-contact-lenses-cp-ni/lcrb.html
        name: 'SofLens Daily Disposables 90pk',
        brand: 'SofLens',
        type: 'Daily Disposable',
        manufacturer: 'Bausch & Lomb',
        material: '70 % water content - hilafilcon A. Visibility tint.',
        price: '47.75',
        images: ['soflens-02.jpg'],
    },
    {
        # http://www.framesdirect.com/Soflens-Multi-Focal-contact-lenses-cp-ni/lcrd.html
        name: 'SofLens Multi-Focal',
        brand: 'SofLens',
        type: 'BiFocal',
        manufacturer: 'Bausch & Lomb',
        material: '38.6 % water content - polymacon. Visibility tint.',
        price: '39.75',
        images: ['soflens-03.jpg'],
        prescription_category_id: 3,
    },
    {
        # http://www.framesdirect.com/Soflens-Toric-6-pack-contact-lenses-cp-ni/k.html
        name: 'SofLens Toric (6 pack)',
        brand: 'SofLens',
        type: 'Toric',
        manufacturer: 'Bausch & Lomb',
        material: '66% water content - alphafilcon A. Visibility tint',
        price: '32.75',
        images: ['soflens-04.jpg'],
        prescription_category_id: 2,
    },
]

contact_lenses.each do |contact_lenses_attrs|
    attrs = default_attrs.merge(contact_lenses_attrs)

    images = attrs.delete(:images)
    brand = attrs.delete(:brand)
    type = attrs.delete(:type)
    manufacturer = attrs.delete(:manufacturer)
    material = attrs.delete(:material)

    contact_lens = ContactLens.create!(attrs)

    contact_lens.set_property('Material', material) if material

    Spree::Taxon.find_or_create_by(name: 'Contact Lenses', taxonomy: Spree::Taxonomy.find_by(name: 'Category')).products << contact_lens
    Spree::Taxon.find_or_create_by(name: brand, taxonomy: Spree::Taxonomy.find_by(name: 'Brand')).products << contact_lens
    Spree::Taxon.find_or_create_by(name: type, taxonomy: Spree::Taxonomy.find_by(name: 'Type')).products << contact_lens
    Spree::Taxon.find_or_create_by(name: manufacturer, taxonomy: Spree::Taxonomy.find_by(name: 'Manufacturer')).products << contact_lens

    # 263 x 205
    images.each do |image|
        contact_lens.master.images.create!({attachment: File.open(Rails.root.join("doc/seed/contact_lenses/#{image}"))})
    end
end
