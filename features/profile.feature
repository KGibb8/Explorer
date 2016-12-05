Feature: Profile
  As a lurker
  I should be able to view a user's profile

  As a logged in user
  I can view my profile
  I can upload a profile picture
  I can edit my biography

  Background:
    Given sample users have been created

  Scenario: Visiting a profile page
    When I navigate to "tara@enlightened.being" profile page
    Then the page contains "Green Tara"

  @poltergeist
  Scenario: Uploading a profile picture
    Given I am logged in as "tara@enlightened.being"
    When I navigate to "tara@enlightened.being" profile page
    And I fill in the "file" field for "edit_profile" form
    And I click "Update Profile"
    Then the page contains "green_tara"


