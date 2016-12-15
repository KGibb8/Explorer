Then(/^the page contains a selection of the most recent expeditions$/) do
  within('#mostRecent') do
    expect(page.body).to have_content('lao_tzu')
  end
end

Then(/^the page contains a selection of the most popular expeditions$/) do
  pending
end

Then(/^a new Expedition is created$/) do
end

Then(/^I am redirected to the specific expedition page$/) do
  visit get_named_route('expedition', Expedition.last.id)
end

When(/^I navigate to the specific expedition page$/) do
  visit get_named_route('expedition', Expedition.last.id)
end

When(/^I tick "([^"]*)" for the user "([^"]*)"$/) do |element_id, username|
  checkbox = element_id + User.find_by(username: username).id.to_s
  find(:css, checkbox).set(true)
end

