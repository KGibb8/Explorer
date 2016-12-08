Then(/^the page contains a selection of the most recent expeditions$/) do
  save_and_open_page
  within('#mostRecent') do
    expect(page.body).to have_content('by lao_tzu')
  end
end

Then(/^the page contains a selection of the most popular expeditions$/) do
  pending
end

Then(/^the page contains the activities of the users I follow$/) do
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^a new Expedition is created$/) do
end

Then(/^I am redirected to the specific expedition page$/) do
  visit get_named_route('expedition', Expedition.last.id)
end

When(/^I navigate to the specific expedition page$/) do
  visit get_named_route('expedition', Expedition.last.id)
end
