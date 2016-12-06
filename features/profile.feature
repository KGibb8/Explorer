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

