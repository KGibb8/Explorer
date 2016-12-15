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
    When I navigate to "green_tara@enlightened.being" profile page
    Then the page contains "green_tara"

  Scenario: Editing my biography
    Given I am logged in as "green_tara@enlightened.being"
    When I navigate to "green_tara@enlightened.being" profile page
    And I fill in the "profile[biography]" field with "I start fires"
    And I click "Update Biography"
    Then the page contains "I start fires"

  Scenario: Editing my name 
    Given I am logged in as "green_tara@enlightened.being"
    When I navigate to "green_tara@enlightened.being" profile page
    And I fill in the "profile[first_name]" field with "Red"
    And I fill in the "profile[last_name]" field with "Behemoth"
    And I click "Update Name"
    Then the page contains "Red"
    Then the page contains "Behemoth"

