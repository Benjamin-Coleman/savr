require_relative "../rails_helper.rb"

describe 'Feature Test: User Signup', :type => :feature do

  it 'successfully navigates to the signup page' do
    visit_signup
    expect(current_path).to eq('/signup')
  end

  it 'successfully signs up' do
    visit_signup
    expect(current_path).to eq('/signup')
    user_signup
    expect(current_path).to eq('/listings')
    expect(page).to have_content("Listings")
  end
end

describe 'Feature Test: User Sign In', :type => :feature do

  it 'successfully navigates to the login page' do
    visit_login
    expect(current_path).to eq('/login')
  end

  it 'successfully logs in' do
    visit_login
    expect(current_path).to eq('/login')
    user_login
    expect(current_path).to eq('/listings')
    expect(page).to have_content("Listings")
  end
end


describe 'Feature Test: User Profile', :type => :feature do

  it 'successfully navigates to the profile page' do
    visit_login
    expect(current_path).to eq('/login')
    user_login
    expect(current_path).to eq('/listings')
    expect(page).to have_content("Listings")

    click_link('Profile', match: :first)
    expect(current_path).to eq("/users/#{@mindy.id}")
  end

  it 'profile page displays correct content depending on current user' do
    visit_login
    expect(current_path).to eq('/login')
    user_login
    expect(current_path).to eq('/listings')
    expect(page).to have_content("Listings")

    click_link('Profile', match: :first)
    expect(current_path).to eq("/users/#{@mindy.id}")

    expect(page).to have_content("My Open Listings")

    visit_different_user
    expect(current_path).to eq("/users/2")
    expect(page).to have_content("Tyler's Open Listings")

  end

end
