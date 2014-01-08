# Method, it's used to generating the title..
def full_title(page_title)
  base_title="Techie Blog! App"
  if page_title.empty?
    base_title
  else
    "#{base_title}|#{page_title}"
  end
end
# Define method based ont he Matcher which will handle the page and generating the message to screen
#
RSpec::Matchers.define :have_error_message do |message|
  match do |page|
    expect(page).to_have_selector('div.alert.alert-error', text: message)
  end
end

# Method valid_signin, it's used to determine the user who have been signned in valid or not...
#
def valid_signin(user)
  fill_in "Email", with: user.email
  fill_in "Password", with: user.password
  click_button "Sign in"
end

#Method sign_in, It's used to implement the signin procedures..
#
def sign_in(user,options={})
  if options[:no_capybara]
    # Sign in when not using Capybara
    remember_token = User.new_remember_token
    cookies[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.encrypt(remember_token))
  else
    visit signin_path
    fill_in "Email",    with: user.email
    fill_in "Password", with: user.password
    click_button "Sign in"
  end
end