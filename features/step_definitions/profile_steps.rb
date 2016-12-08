When(/^I navigate to "([^"]*)" profile page$/) do |email|
  user = User.find_by(email: email)
  visit user_profile_path(user)
end


