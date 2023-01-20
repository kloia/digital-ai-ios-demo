login_page = LoginPage.new

Given(/^fill user name on the page$/) do
  login_page.set_identifier(CREDENTIAL[:user][:name])
end

And(/^fill password on the page$/) do
  login_page.set_password((CREDENTIAL[:user][:pass]))
end

When(/^click login on the page$/) do
  login_page.click_login
end

Then(/^verify home page$/) do
  login_page.verify_login
end

And(/^logout$/) do
  login_page.click_logout
end

Then(/^verify logout$/) do
  login_page.verify_logout
end

Then(/^verify login$/) do
  login_page.verify_login
end