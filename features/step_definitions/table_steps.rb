Given('I am logged in') do
    @user = FactoryBot.create :owner
    visit '/users/sign_in'
    fill_in 'Email', with: @user.email
    fill_in 'Password', with: @user.password
    click_button 'Log in'
  end


When('I create a new restaurant') do
    visit '/restaurants/new'
    @restaurant = FactoryBot.create :restaurant
    fill_in 'Name', with: @restaurant.name
    fill_in 'Address', with: @restaurant.address
    click_button "Create Restaurant"
end

When('I visit the restaurant page') do
    visit '/restaurants/696'
    expect(page).to have_content @restaurant.name
    expect(page).to have_content @restaurant.address
end

When('I create a new table and a queue and set myself to a table') do
    @queue = FactoryBot.create :wait_queue
    visit '/restaurants/696/restaurant_tables'
    find_link('New Table', href: '/restaurants/696/restaurant_tables').click
    expect(page).to have_content @user.id
    expect(page).to have_content 'waiting'
    find('select', :text => '1').click
    click_button "Set"
    expect(page).to have_content "Busy"
end
