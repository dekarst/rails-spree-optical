puts 'User'

user = User.create!(email: 'user@example.com', password: '123456', verify_18_years: true)
admin = User.create!(email: 'admin@example.com', password: '123456', verify_18_years: true)

# admin.spree_roles << Spree::Role.find_or_create_by(name: 'admin')
