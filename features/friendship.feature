Feature: Friendship
  As a logged on user
  I should be able to visit my profile page and see a list of my friends
  I should be able to visit another user's profile and choose to add friend
  I should then be able to see this user in my requested_friends 
  And the opposite user should be able to see my in their friend requests
  I should be able to accept friendships
  I should then see this friend in the list of friends on my profile
  And the opposite user should be able to see my in their list of friends
  I should be able to reject a suggested friendship

  Background:
    Given sample users have been created
    Given I am logged in as "green_tara@enlightened.being"

  Scenario: Viewing my friends
    Given sample friendships have been confirmed
    When I navigate to "green_tara@enlightened.being" profile page
    Then the page contains "lao_tzu"
    And the page contains "shakyamuni"

  Scenario: Requesting a friend
    When I navigate to "shakyamuni@enlightened.being" profile page
    And I click "Add Friend"
    Then the page contains "Request Sent"

  Scenario: Accepting a friend
    Given sample friend requests have been created
    When I navigate to "green_tara@enlightened.being" profile page
    And I click "Accept Request" for the friend "shakyamuni@enlightened.being"
    Then the page contains "Friendship Accepted"
    And the page contains "shakyamuni"

  Scenario: Rejecting a friend
    Given sample friend requests have been created
    When I navigate to "green_tara@enlightened.being" profile page
    And I click "Reject Request" for the friend "shakyamuni@enlightened.being"
    Then the page contains "Friendship Rejected"
