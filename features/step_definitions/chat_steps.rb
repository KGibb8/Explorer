Then(/^I am redirected to the expedition chats page$/) do
  visit get_named_route('expedition_chats', Expedition.last)
end
