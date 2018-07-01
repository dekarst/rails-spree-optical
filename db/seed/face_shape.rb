puts 'FaceShape'

FaceShape.create!(name: 'Oval', image: File.open(Rails.root.join('doc', 'seed', 'face_shapes', 'oval.jpg')))
