require 'spec_helper'

feature 'User sign up' do
    scenario "signs up successfully" do
        visit root_path
        click_link 'Sign up'
        expect(page.current_url).to eq new_user_registration_url
        fill_in_fields
        click_button 'Save'
        expect(page.current_url).to eq root_url
        expect(page).to have_content("Welcome! You have signed up successfully")
    end

    scenario "attempts to sign up with missing email and fails" do
        visit root_path
        click_link 'Sign up'
        expect(page.current_url).to eq new_user_registration_url
        fill_in_fields(email: '')
        click_button 'Save'
        expect(page.current_url).to eq new_user_registration_url
        expect(page).to have_content("Some errors were found, please take a look")
        expect(page).to have_content("Emailcan't be blank")
    end

    scenario "attempts to sign up with missing password and fails" do
        visit root_path
        click_link 'Sign up'
        expect(page.current_url).to eq new_user_registration_url
        fill_in_fields(password: '')
        click_button 'Save'
        expect(page.current_url).to eq new_user_registration_url
        expect(page).to have_content("Some errors were found, please take a look")
        expect(page).to have_content("Passwordcan't be blank")
    end

    scenario "attempts to sign up with missing password confirmation and fails" do
        visit root_path
        click_link 'Sign up'
        expect(page.current_url).to eq new_user_registration_url
        fill_in_fields(password_confirmation: '')
        click_button 'Save'
        expect(page.current_url).to eq new_user_registration_url
        expect(page).to have_content("Some errors were found, please take a look")
        expect(page).to have_content("Passwordcan't be blank")
    end

    scenario "attempts to sign up with two missing fields and fails" do
        visit root_path
        click_link 'Sign up'
        expect(page.current_url).to eq new_user_registration_url
        fill_in_fields(email: '', password: '')
        click_button 'Save'
        expect(page.current_url).to eq new_user_registration_url
        expect(page).to have_content("Some errors were found, please take a look")
        expect(page).to have_content("Emailcan't be blank")
        expect(page).to have_content("Passwordcan't be blank")
    end

    scenario "attempts to sign up with different password confirmation and fails" do
        visit root_path
        click_link 'Sign up'
        expect(page.current_url).to eq new_user_registration_url
        fill_in_fields(password_confirmation: '654321')
        click_button 'Save'
        expect(page.current_url).to eq new_user_registration_url
        expect(page).to have_content("Some errors were found, please take a look")
        expect(page).to have_content("Password confirmationdoesn't match Password")
    end
end

def fill_in_fields(opts={})
    opts.reverse_merge!({
        email: 'user@example.com',
        password: '123456',
        password_confirmation: '123456',
    })

    fill_in 'Email', with: opts[:email]
    fill_in 'Password', with: opts[:password]
    fill_in 'Password confirmation', with: opts[:password_confirmation]
end
