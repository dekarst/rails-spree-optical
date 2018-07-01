namespace :framesdirect do
    desc "Download FramesDirect products"
    task :download, [:url, :category] => :environment do |t, args|
        if args[:url].present?
            require 'rubygems'
            require 'headless'
            require 'selenium-webdriver'
            require 'colorize'

            headless = Headless.new
            headless.start

            browser = Selenium::WebDriver.for :firefox
            wait = Selenium::WebDriver::Wait.new(timeout: 15)

            loop do
                begin
                    browser.get args[:url]
                rescue Net::ReadTimeout => e
                    puts "#{e.class}".yellow
                    next
                end

                break
            end

            current_frame = {}

            loop do
                begin
                    name = browser.find_element(:xpath, "//div[@id='prod-header-right-inner']//h1").text.strip
                    puts name.white

                    current_frame[:category] = args[:category]
                    current_frame[:category] ||= 'Sunglasses'
                    current_frame[:name] = name
                    current_frame[:description] = browser.find_elements(:xpath, "//div[@itemprop='description']").select {|div| div.attribute('class') == ''}.first.text
                    current_frame[:brand] = browser.find_element(:xpath, "//div[@itemprop='brand']").find_element(:xpath, ".//span[@itemprop='name']").text
                    current_frame[:gender] = browser.find_element(:id, 'prod-features').find_elements(:tag_name, :li).first.text
                    current_frame[:material] = browser.find_element(:id, 'prod-features').find_elements(:tag_name, :li).last.text
                rescue Net::ReadTimeout => e
                    puts "#{e.class}".yellow
                    next
                end

                break
            end

            current_frame[:colors] = []
            browser.find_elements(:xpath, "//div[@id='prod-show-all-colors']//div[@class='ProductImage']").each do |color|
                color.click
                sleep 5

                price = browser.find_element(:id, 'spanOurPrice').text.gsub(/[a-zA-Z]/, '').strip.to_f
                retail_price = nil
                begin
                    retail_price = browser.find_element(:id, 'spanRetailPrice').text.gsub(/[a-zA-Z]/, '').strip.to_f
                rescue Selenium::WebDriver::Error::NoSuchElementError
                end
                color_name = browser.find_element(:id, 'prod-selected-color-name').text.strip
                puts "#{color_name}\t(#{price})"

                current_color = {name: color_name, price: price, retail_price: retail_price, images: [], variants: []}

                alternate_views = browser.find_element(:id, 'alternateViews')
                if alternate_views.displayed?
                    browser.find_elements(:xpath, "//div[@id='alternateViews']//div[@class='img-block']").each do |image|
                        image.click
                        sleep 5

                        large_image = browser.find_element(:id, 'largeimage').attribute('href')

                        current_color[:images] << large_image
                    end
                else
                    large_image = browser.find_element(:id, 'largeimage').attribute('href')

                    current_color[:images] << large_image
                end

                ths = browser.find_elements(:xpath, "//table[@id='sizetable-heading']//th[@style='width: 15%']").map(&:text).map(&:downcase)

                browser.find_elements(:xpath, "//table[@id='sizetable']//tr").select {|tr| tr.attribute('style') != "display: none\;"}.each do |tr|
                    current_variant = {}

                    tr.find_elements(:tag_name, :td).select {|td| td.attribute('style') == "width: 15%\;"}.each_with_index do |td, i|
                        current_variant[ths[i].to_sym] = td.text.gsub(/[a-zA-Z]/, '').strip.to_f
                    end

                    current_color[:variants] << current_variant
                end

                current_frame[:colors] << current_color
            end

            File.open(Rails.root.join('doc', 'seed', 'framesdirect', "#{current_frame[:name].gsub(/\W+/, '-')}.yml"), 'w') do |file|
                file.write current_frame.to_yaml
            end

            browser.quit
            headless.destroy
        end
    end

    desc "Import FramesDirect products"
    task :import, [:file] => :environment do |t, args|
        require 'open-uri'

        Frame.destroy_all unless args[:file].present?

        default_attrs = {
            description: Faker::Lorem.paragraph,
            available_on: Time.zone.now,
            tax_category: Spree::TaxCategory.find_by_name!('Frames'),
        }

        files = [args[:file]] if args[:file].present?
        files ||= Dir.glob(Rails.root.join('doc', 'seed', 'framesdirect', '*'))

        files.each do |file|
            frame_attributes = YAML::load_file(file)

            puts frame_attributes[:name]

            frame = Frame.create!(default_attrs.reverse_merge({
                name: frame_attributes[:name], description: frame_attributes[:description],
                price: frame_attributes[:colors].first.try(:[], :price), retail_price: frame_attributes[:colors].first.try(:[], :retail_price),
            }))

            frame.set_property('Material', frame_attributes[:material])

            frame_attributes[:category] ||= 'Sunglasses'

            Spree::Taxon.find_or_create_by(name: frame_attributes[:category], taxonomy_id: 1).products << frame
            Spree::Taxon.find_or_create_by(name: frame_attributes[:brand], taxonomy_id: 2).products << frame
            Spree::Taxon.find_or_create_by(name: frame_attributes[:gender], taxonomy_id: 3).products << frame

            frame_attributes[:colors].each do |color|
                puts "\t#{color[:name]}"

                first_variant = nil
                color[:variants].each do |variant_options|
                    next if variant_options.empty?

                    frame_color = FrameColor.find_or_create_by!(name: color[:name], frame: frame)

                    variant = frame.variants.create!(price: color[:price], retail_price: color[:retail_price], frame_color: frame_color)
                    first_variant ||= variant

                    variant_options.each do |option_type, option_value|
                        variant.set_option_value(option_type, option_value)
                    end

                    Spree::StockMovement.create!(stock_item: variant.stock_items.first, quantity: 10) if variant.present?
                end

                if first_variant.present?
                    if color[:images].present?
                        color[:images].each do |image|
                            begin
                                first_variant.images.create!({attachment: open(image)})
                            rescue OpenURI::HTTPError => e
                                puts "#{e.class}".yellow
                            end
                        end
                    end
                end
            end
        end

        Rake::Task['seed:distribute_lenses'].execute
        Rake::Task['seed:set_colors'].execute
        Rake::Task['seed:fix_taxons'].execute
        Rake::Task['seed:set_taxons'].execute
    end

    desc "Download All FramesDirect products"
    task download_all: :environment do
        # Rake::Task['framesdirect:download'].execute url: 'http://www.framesdirect.com/framesfp/Ray-Ban_RX-tdnisi/r.html', category: 'Eyeglasses'
    end
end
