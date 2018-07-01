require 'spec_helper'

feature 'User sign out' do
    before :each do
        FactoryGirl.create(:user, email: 'user@example.com')
    end

    scenario "signs out successfully" do
        visit root_path
        click_link 'Login'
        fill_in 'Email', with: 'user@example.com'
        fill_in 'Password', with: '123456'
        click_button 'Sign in'
        click_link 'Log out'
        expect(page.current_url).to eq root_url
        expect(page).to have_content("Signed out successfully")
    end
end
