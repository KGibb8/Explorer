Given(/^I am logged in as "([^"]*)"$/) do |email|
  user_const = Object.const_get('User') if Object.const_defined?('User')
  @logged_on_user = user_const.find_by(email: email) unless user_const.nil?
  log_on_as(@logged_on_user || email)
end

Given(/^I am on the "([^"]*)" page$/) do |path|
  visit get_named_route(path)
end

When(/^I fill in the "([^"]*)" field with "([^"]*)"$/) do |label, content|
  fill_in label, with: content
end

When(/^I click "([^"]*)"$/) do |link|
  click_on link
end

Then(/^the page contains "([^"]*)"$/) do |text|
  expect(page.body).to match(text)
end

When(/^I navigate to the "([^"]*)" page$/) do |path|
  visit get_named_route(path)
end

Then(/^I am redirected to the "([^"]*)" page$/) do |inner_resource|
end
