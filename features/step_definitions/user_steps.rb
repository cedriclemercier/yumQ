Given(/^I am a user$/) do
    @user = FactoryBot.create :owner
  end

Given(/^I am signed in$/) do
    visit '/users/sign_in'
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Log in'
end

Given(/^I see manage restaurants button$/) do
    click_link 'Manage restaurants'
end

When(/^I visit the manage restaurant section$/) do
    visit '/restaurants'
end

When(/^I should see a link to create a restaurant$/) do
    expect(page).to have_link('New Restaurant', href: new_restaurant_path)
end

When(/^I click the link to create a restaurant$/) do
    find_link('New Restaurant', href: new_restaurant_path).click
end

Then(/^I should see the the form details to create it$/) do
    expect(page).to have_field "Name"
    expect(page).to have_field "Address"
end

When(/^I submit the form$/) do
    visit '/restaurants/new'
    @restaurant = FactoryBot.create :restaurant
    fill_in 'Name', with: @restaurant.name
    fill_in 'Address', with: @restaurant.address
    click_button "Create Restaurant"
end

Then(/^I should see the details of my restaurant$/) do
    visit '/restaurants/696'
    expect(page).to have_content @restaurant.name
    expect(page).to have_content @restaurant.address
end

