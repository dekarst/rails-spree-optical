puts 'Menu'

Menu.create!(name: 'Header')
Menu.create!(name: 'Footer')

puts 'MenuItem'

MenuItem.create!(menu_id: 1, content: 'Home', url: '/', position: 1)
MenuItem.create!(menu_id: 1, content: 'About', page: Spree::Page.find_by(slug: '/about'), link_to_page: true, position: 2)
MenuItem.create!(menu_id: 1, content: 'Contacts', url: '/t/category/contact-lenses', position: 3)
MenuItem.create!(menu_id: 1, content: 'Eyeglasses', url: '/t/category/eyeglasses', position: 4)
MenuItem.create!(menu_id: 1, content: 'Sunglasses', url: '/t/category/sunglasses', position: 5)
MenuItem.create!(menu_id: 1, content: 'Speciality', page: Spree::Page.find_by(slug: '/speciality'), link_to_page: true, position: 6)

MenuItem.create!(menu_id: 2, content: 'Contacts', url: '/t/category/contact-lenses', position: 1)
MenuItem.create!(menu_id: 2, content: 'Eyeglasses', url: '/t/category/eyeglasses', position: 2)
MenuItem.create!(menu_id: 2, content: 'Sunglasses', url: '/t/category/sunglasses', position: 3)
MenuItem.create!(menu_id: 2, content: 'Speciality', page: Spree::Page.find_by(slug: '/speciality'), link_to_page: true, position: 4)
MenuItem.create!(menu_id: 2, content: 'FAQ´s', page: Spree::Page.find_by(slug: '/faq'), link_to_page: true, position: 5)
MenuItem.create!(menu_id: 2, content: 'Shipping', page: Spree::Page.find_by(slug: '/shipping'), link_to_page: true, position: 6)
