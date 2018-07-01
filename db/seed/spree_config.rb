puts 'Spree Config'

Spree::Config.site_name = 'EyeBuy For Less | Sunglasses and Eyeglasses For Sale'
Spree::Config.short_site_name = 'EyeBuy For Less'

Spree::Config.mail_host = 'mailtrap.io'
Spree::Config.mail_domain = 'mailtrap.io'
Spree::Config.mail_port = 2525
Spree::Config.mails_from = 'spree@example.com'
Spree::Config.mail_auth_type = 'Login'
Spree::Config.smtp_username = 'optical-16525f64cd3ca3ea'
Spree::Config.smtp_password = '5b9df5be1dd3a076'

# TODO fix
# :attachment_styles has been removed from Spree::Config. Where to set it now?

# Spree::Config[:attachment_styles] = {
#     mini: '100x100#',
#     small: '235x96>',
#     product: '716x352>',
#     large: '1478x704>',
#     details: '189x149>'
# }.to_json

SpreeBanner::Config.banner_styles = {
    mini: '48x48>',
    small: '100x100>',
    large: '800x200>',
    vertical: '170x1000>',
}.to_json
SpreeBanner::Config.banner_default_style = 'large'
