def setup_contact_lens_category
    @contact_lens_category = FactoryGirl.create(:contact_lens_category, name: 'Cylindrical contacts (single vision)')

    @item_power = FactoryGirl.create(:contact_lens_item, name: 'Power', contact_lens_category: @contact_lens_category)
    (50..600).step(25).map {|n| -n/100.0}.each {|value| @item_power.contact_lens_values << FactoryGirl.create(:contact_lens_value, name: ("%.2f" % value))}
    @item_bc = FactoryGirl.create(:contact_lens_item, name: 'Base Curve (BC)', contact_lens_category: @contact_lens_category)
    [8.4, 8.8].each {|value| @item_bc.contact_lens_values << FactoryGirl.create(:contact_lens_value, name: ("%.2f" % value))}
    @item_dia = FactoryGirl.create(:contact_lens_item, name: 'Diameter (DIA)', contact_lens_category: @contact_lens_category)
    [14.0].each {|value| @item_dia.contact_lens_values << FactoryGirl.create(:contact_lens_value, name: ("%.2f" % value))}
end

def contact_lens_page
    expect(page.current_path).to eq spree.product_path(@contact_lens)

    expect(page).to have_content('AWESOME CONTACT LENS')

    expect(page).to have_content('R (OD)')
    expect(page).to have_content('L (OS)')

    expect(page).to have_content('Power')
    expect_contact_lens_values ['-0.50', '-0.75', '-1.00', '-1.25', '-5.50', '-5.75', '-6.00']

    expect(page).to have_content('Base Curve (BC)')
    expect_contact_lens_values ['8.4', '8.8']

    expect(page).to have_content('Diameter (DIA)')
    expect_contact_lens_values ['14.0']
end

def expect_contact_lens_values(values)
    values.each do |value|
        expect(page).to have_content(value)
    end
end

def select_options
    within '#contact-lens-options' do
        all('option:last-child').each do |option|
            option.select_option
        end
    end
end
