puts 'LensThickness'

lens_thickness = LensThickness.create!(name: 'Standard', description: 'Regular Lens Thickness', image: File.open(Rails.root.join('doc', 'seed', 'lens_thicknesses', '01.png')))
lens_thickness.lens_thickness_options.create!(name: 'Default', price: 80)

lens_thickness = LensThickness.create!(name: 'Polycarbonate', description: '30% Thinner than Standard', image: File.open(Rails.root.join('doc', 'seed', 'lens_thicknesses', '01.png')), recommended: true)
lens_thickness.lens_thickness_options.create!(name: 'Normal', price: 125)
lens_thickness.lens_thickness_options.create!(name: 'Transparency', price: 150)

lens_thickness = LensThickness.create!(name: 'Hi Index 1.67', description: '45% Thinner than Standard', image: File.open(Rails.root.join('doc', 'seed', 'lens_thicknesses', '01.png')))
lens_thickness.lens_thickness_options.create!(name: 'Default', display_name: 'Select', price: 229)
