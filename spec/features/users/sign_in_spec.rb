require 'spec_helper'

feature 'User sign in' do
    before :each do
        FactoryGirl.create(:user, email: 'user@example.com')
    end

    scenario "signs in successfully" do
        visit root_path
        click_link 'Login'
        expect(page.current_url).to eq new_user_session_url
        fill_in 'Email', with: 'user@example.com'
        fill_in 'Password', with: '123456'
        click_button 'Sign in'
        expect(page.current_url).to eq root_url
        expect(page).to have_content('Signed in successfully')
    end

    scenario "attempts to sign in with unregistered email and fails" do
        visit root_path
        click_link 'Login'
        expect(page.current_url).to eq new_user_session_url
        fill_in 'Email', with: 'wrong-user@example.com'
        fill_in 'Password', with: '123456'
        click_button 'Sign in'
        expect(page.current_url).to eq new_user_session_url
        expect(page).to have_content('Invalid login or password')
    end

    scenario "attempts to sign in with wrong password and fails" do
        visit root_path
        click_link 'Login'
        expect(page.current_url).to eq new_user_session_url
        fill_in 'Email', with: 'user@example.com'
        fill_in 'Password', with: '654321'
        click_button 'Sign in'
        expect(page.current_url).to eq new_user_session_url
        expect(page).to have_content('Invalid login or password')
    end

    scenario "access the root page while siggned in and sees his email" do
        login(email: 'dwight@example.com')

        visit root_path
        expect(page).to have_content('Logged in as: dwight@example.com')
    end
end
