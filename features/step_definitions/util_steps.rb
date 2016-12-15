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

When(/^I press "([^"]*)"(?: on "([^"]*)"|)$/) do |key, css_selector|
  css_selector ||= 'body'
  case key
  when "ENTER"
    keycode = 13
  when "TAB"
    keycode = 9
  when "SPACE"
    keycode = 32
  end
  keypress_script = "var e = $.Event('keydown', { keyCode: #{keycode}   }); $('#{css_selector}').trigger(e);"
  page.driver.execute_script(keypress_script)
end

When(/^I sleep "([^"]*)"$/) do |seconds|
  sleep seconds.to_i
end


When(/^I click "([^"]*)"$/) do |link|
  click_on link
end

When(/^I click on "([^"]*)"$/) do |element|
  find(:css, element).click
end

Then(/^the page contains "([^"]*)"(?: "([^"]*)"|)(?: "([^"]*)"|)$/) do |text, more_text, and_more_text|
  more_text ||= ""
  and_more_text ||= ""
  expect(page.body).to match(text)
  expect(page.body).to match(more_text)
  expect(page.body).to match(and_more_text)
end

Then(/^the page does not contain "([^"]*)"$/) do |text|
  expect(page.body).to_not match(text)
end

When(/^I navigate to the "([^"]*)" page$/) do |path|
  visit get_named_route(path)
end

Then(/^I am redirected to the "([^"]*)" page$/) do |inner_resource|
  visit get_named_route(inner_resource)
end

Then(/^within "([^"]*)" the page contains "([^"]*)"$/) do |element, text|
  expect(page).to have_css(element, :text => text)
end
