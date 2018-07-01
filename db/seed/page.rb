puts 'Page'

Spree::Page.create!(title: 'Home', foreign_link: '/')
Spree::Page.create!(title: 'About', body: "About Us", slug: '/about')
Spree::Page.create!(title: 'Contacts', foreign_link: '/t/category/contact-lenses')
Spree::Page.create!(title: 'Eyeglasses', foreign_link: '/t/category/eyeglasses')
Spree::Page.create!(title: 'Sunglasses', foreign_link: '/t/category/sunglasses')
Spree::Page.create!(title: 'Speciality', body: "Speciality", slug: '/speciality')

Spree::Page.create!(title: 'FAQ´s', body: "FAQ", slug: '/faq')
Spree::Page.create!(title: 'Shipping', body: "Shipping", slug: '/shipping')
