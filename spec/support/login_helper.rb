require 'pry'
module LoginHelper

  def visit_signup
    visit '/'
    click_link('Sign Up')
  end

  def user_signup
    fill_in("user[name]", :with => "Kanye")
    fill_in("user[password]", :with => "password")
    fill_in("user[password_confirmation]", :with => "password")
    click_button('Sign Up')
  end

  def visit_login
    visit '/'
    click_link('Sign In', match: :first)
  end

  def user_login

    @mindy = User.create(
      name: "Mindy",
      password: "password"
    )

    fill_in("user[name]", :with => "Mindy")
    fill_in("user[password]", :with => "password")
    click_button('Login')
  end

  def visit_user_profile
    click_link('Profile', match: :first)
  end

  def visit_different_user
    visit('/users/2')
  end


end
