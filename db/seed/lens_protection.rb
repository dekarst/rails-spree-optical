puts 'LensProtection'

lens_protection = LensProtection.create!(name: 'Light Transitions', description: 'Add Light-Adjusting Option', image: File.open(Rails.root.join('doc', 'seed', 'lens_protections', '01.png')))
lens_protection.lens_protection_options.create!(name: 'Gray', display_name: 'Add Gray', price: 90)
lens_protection.lens_protection_options.create!(name: 'Brown', display_name: 'Add Brown', price: 90)

lens_protection = LensProtection.create!(name: 'Anti-Reflective', description: 'Add Glar-Free Option', image: File.open(Rails.root.join('doc', 'seed', 'lens_protections', '02.png')))
lens_protection.lens_protection_options.create!(name: 'Standard', price: 70)
lens_protection.lens_protection_options.create!(name: 'Premium', price: 100)

lens_protection = LensProtection.create!(name: 'Dark Transitions', description: 'Add Dark Sunglass Option', image: File.open(Rails.root.join('doc', 'seed', 'lens_protections', '03.png')))
lens_protection.lens_protection_options.create!(name: 'Gray', display_name: 'Add Gray', price: 95)
lens_protection.lens_protection_options.create!(name: 'Brown', display_name: 'Add Brown', price: 95)

lens_protection = LensProtection.create!(name: 'UV Protection', description: 'Add 100% UV Protection Option', image: File.open(Rails.root.join('doc', 'seed', 'lens_protections', '04.png')))
lens_protection.lens_protection_options.create!(name: 'Default', display_name: 'Select', price: 150)
