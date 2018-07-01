puts 'PageContent'

sun_img = Ckeditor::Picture.create!(data: File.open(Rails.root.join('doc', 'seed', 'pages', 'sun.png')))
sunglass_img = Ckeditor::Picture.create!(data: File.open(Rails.root.join('doc', 'seed', 'pages', 'sunglass3.png')))
girl_img = Ckeditor::Picture.create!(data: File.open(Rails.root.join('doc', 'seed', 'pages', 'girl.png')))
options_img = [
    Ckeditor::Picture.create!(data: File.open(Rails.root.join('doc', 'seed', 'pages', 'options_01.png'))),
    Ckeditor::Picture.create!(data: File.open(Rails.root.join('doc', 'seed', 'pages', 'options_02.png'))),
    Ckeditor::Picture.create!(data: File.open(Rails.root.join('doc', 'seed', 'pages', 'options_03.png'))),
]
best_brands_img = Ckeditor::Picture.create!(data: File.open(Rails.root.join('doc', 'seed', 'pages', 'best_brands.png')))
brands_img = [
    Ckeditor::Picture.create!(data: File.open(Rails.root.join('doc', 'seed', 'pages', 'kate-spade.png'))),
    Ckeditor::Picture.create!(data: File.open(Rails.root.join('doc', 'seed', 'pages', 'lacoste.png'))),
    Ckeditor::Picture.create!(data: File.open(Rails.root.join('doc', 'seed', 'pages', 'ray-ban.png'))),
]

PageContent.create!(title: 'Home', body: "
<div class='mainbody'>
    <div class='container'>
        <div class='row'>
            <div class='col3 col-tb-12 col-mbl-12 add'>
                <p class='h1 lead text-info text-center'>SUNWEAR</p>
                <center><img src='#{sun_img.url}' class='img-responsive' /></center>
                <p class='lead text-center'><strong>get <span class='h1 text-info'>25% </span> OFF</strong></p>
                <center><small>Burberry Oversized Round Sunglasses</small></center>
                <div class='vr'></div>
            </div>

            <div class='h-d'>
                <div class='vsap'></div>
                <div class='vsap'></div>
                <div class='hr'></div>
                <div class='vsap'></div>
                <div class='vsap'></div>
            </div>

            <div class='col3 col-tb-12 col-mbl-12 add'>
                <p class='h2 lead text-center'>2013NEW</p>
                <p class='h3 lead text-center'><strong>SPRING</strong>COLLECTIONS</p>
                <center><img src='#{sunglass_img.url}' class='img-responsive' /></center>
                <p class='lead text-center'><strong>get <span class='h1 text-info'>25% </span> OFF</strong></p>
                <center><small>Burberry Oversized Round Sunglasses</small></center>
                <div class='vr'></div>
            </div>

            <div class='h-d'>
                <div class='vsap'></div>
                <div class='vsap'></div>
                <div class='hr'></div>
                <div class='vsap'></div>
                <div class='vsap'></div>
            </div>

            <div class='col6 col-tb-12 col-mbl-12 add'>
                <div class='row'>
                    <div class='col6'>
                        <div class='h3 text-info'>VIRTUAL</div>
                        <div class='h1'>TRYON</div>
                        <small>find the rigth size for your face ></small>
                        <div class='vsap'></div>
                        <div class='vsap'></div>
                        <a href='#' class='btn btn-primary'>GET STARTED</a>
                    </div>
                    <div class='col-sm-6'>
                        <img src='#{girl_img.url}' class='img-responsive' />
                    </div>
                </div>

                <a href='#'><img src='#{options_img[0].url}' /></a>
                <a href='#'><img src='#{options_img[1].url}' /></a>
                <a href='#'><img src='#{options_img[2].url}' /></a>
            </div>
        </div>
    </div>

    <div class='vsap'></div>
</div>

<div class='bluebar'>
    <div class='container'>
        <div class='row'>
            <div class='brand'>
                <img src='#{best_brands_img.url}' class='brand-text' />
                <a href='#'><img src='#{brands_img[0].url}' class='brand' /></a>
                <a href='#'><img src='#{brands_img[1].url}' class='brand' /></a>
                <a href='#'><img src='#{brands_img[2].url}' class='brand' /></a>
            </div>
        </div>
    </div>
</div>")

PageContent.create!(title: 'Select Prescription Text', body: Faker::Lorem.paragraph(10))

warranty_img = Ckeditor::Picture.create!(data: File.open(Rails.root.join('doc', 'seed', 'pages', 'warranty.png')))
cards = []
6.times do |i|
    cards << Ckeditor::Picture.create!(data: File.open(Rails.root.join('doc', 'seed', 'pages', "card#{i+1}.png")))
end

PageContent.create!(title: 'Warranty', body: "
<div class='row'>
    <div class='col8'>
        <h2 class='light-blue'>1 Year Warranty</h2>
        <p>These pair of glasses come with a one year manufactuer warranty.</p>
    </div>

    <div class='col4'>
        <img src='#{warranty_img.url}' />
    </div>
</div>

<div class='row'>
    <div class='col12'>
        <h2 class='light-blue'>Money Back</h2>
        <p>4 days 100% money back if by any reason you are not happy with your order.</p>
    </div>
</div>

<div class='row payment'>
    <ul>
        <li><a href='javascript:void(0)'><img src='#{cards[0].url}' /></a></li>
        <li><a href='javascript:void(0)'><img src='#{cards[1].url}' /></a></li>
        <li><a href='javascript:void(0)'><img src='#{cards[2].url}' /></a></li>
        <li><a href='javascript:void(0)'><img src='#{cards[3].url}' /></a></li>
        <li><a href='javascript:void(0)'><img src='#{cards[4].url}' /></a></li>
        <li><a href='javascript:void(0)'><img src='#{cards[5].url}' /></a></li>
    </ul>
</div>")

PageContent.create!(title: 'Footer', body:"
<div class='col2'>
    Lorem ipsum dolor sit amet, consectetur adipisicing elit. Esse, quia at repudiandae beatae tempora atque obcaecati dolor autem magni commodi sapiente fugiat repellendus vel tempore ea accusamus quo corrupti quaerat.
</div>

<div class='col2'>
    Lorem ipsum dolor sit amet, consectetur adipisicing elit. Esse, quia at repudiandae beatae tempora atque obcaecati dolor autem magni commodi sapiente fugiat repellendus vel tempore ea accusamus quo corrupti quaerat.
</div>

<div class='col2'>
    Lorem ipsum dolor sit amet, consectetur adipisicing elit. Esse, quia at repudiandae beatae tempora atque obcaecati dolor autem magni commodi sapiente fugiat repellendus vel tempore ea accusamus quo corrupti quaerat.
</div>

<div class='col2'>
    Lorem ipsum dolor sit amet, consectetur adipisicing elit. Esse, quia at repudiandae beatae tempora atque obcaecati dolor autem magni commodi sapiente fugiat repellendus vel tempore ea accusamus quo corrupti quaerat.
</div>

<div class='col2'>
    Lorem ipsum dolor sit amet, consectetur adipisicing elit. Esse, quia at repudiandae beatae tempora atque obcaecati dolor autem magni commodi sapiente fugiat repellendus vel tempore ea accusamus quo corrupti quaerat.
</div>

<div class='col2'>
    Lorem ipsum dolor sit amet, consectetur adipisicing elit. Esse, quia at repudiandae beatae tempora atque obcaecati dolor autem magni commodi sapiente fugiat repellendus vel tempore ea accusamus quo corrupti quaerat.
</div>")

social_img = Ckeditor::Picture.create!(data: File.open(Rails.root.join('doc', 'seed', 'pages', 'social.png')))

PageContent.create!(title: 'Copyright', body:"
<div class='pull-left footer-left'>
    <span> FOLLOW : </span>
    <img src='#{social_img.url}' class='social' />
</div>

<div class='pull-right footer-right'>
    <p>XXXX Street, City, XXX . <a href='mailto:info@somemailhere.com'>info@somemailhere.com</a> © 2013 sitename.com - view <a href='#'>Privacy Policy</a></p>
</div>")

tryon_img = Ckeditor::Picture.create!(data: File.open(Rails.root.join('doc', 'seed', 'pages', 'tryon.jpg')))

PageContent.create!(title: 'Sidebar', body: "
<div class='row addpics'>
    <img src='#{tryon_img.url}' class='img-w'/>
</div>

<div class='vsap'></div>

<div class='row get-start cntr'>
    <p class='p-black p12'>FIND THE RIGHT SIZE FOR YOUR FACE</p>

    <div class='vsap'></div>

    <a href='#' class='getstarted-btn'>GET STARTED</a>

    <div class='vsap'></div>
</div>")
