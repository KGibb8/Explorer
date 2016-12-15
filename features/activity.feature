Feature: Activity

  Background:
    Given sample users have been created
    And sample expeditions have been created

  Scenario: Visiting the root page as a user
    Given I am logged in as "green_tara@enlightened.being"
    When I navigate to the "root" page
    Then the page contains "green_tara" "is attending" "Pilgrimage around Mount Kailash"

