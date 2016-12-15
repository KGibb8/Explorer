Feature: Expedition
  As a logged in user
  On the root page
  I can see a timeline of all the activities of the users I follow
  I can click "Organise Expedition" button to start the process of creating an expedition
  When I do a modal appears requesting details for the Expedition
  It includes a map where I can enter a location and it will geocode to that location
  I can drop a starting location marker and ending location marker on the map to indicate the start and end location
  Once I click "Confirm Expedition" I am prompted to invite people I follow
  I can select users by clicking on a profile picture which highlights that user (or a checkbox)
  I click "Invite" to invite selected users
  I click "Complete" to finish inviting users.
  I am redirected to the "expedition" page of the event I just created
  As the creator/admin I can see a dropdown menu which shows me any user requests to join
  Each requst has a green or red box next to it to indicate whether to accept or reject their request.

  Background:
    Given sample users have been created
    And sample expeditions have been created

  Scenario: Visiting the root page as a lurker
    When I navigate to the "root" page
    Then the page contains a selection of the most recent expeditions

  @poltergeist
  Scenario: Creating an expedition
    Given I am logged in as "green_tara@enlightened.being"
    When I navigate to the "root" page
    And I click "Organise an Expedition"
    And I fill in the "expedition[name]" field with "Going on a Bear Hunt"
    And I fill in the "expedition[description]" field with "Gonna catch a big one"
    And I fill in the "expedition[start_time]" field with "2017-03-10 12:58:41 +0000"
    And I fill in the "expedition[end_time]" field with "2017-08-10 12:58:41 +0000"
    And I click "Create"
    Then I am redirected to the specific expedition page
    And the page contains "Going on a Bear Hunt"

  Scenario: Requesting to join an expedition as a lurker
    When I navigate to the specific expedition page
    And I click "Request to Join"
    Then I am redirected to the "new_user_session" page

  Scenario: Requesting to join an expedition as a logged in user
    Given I am logged in as "green_tara@enlightened.being"
    When I navigate to the specific expedition page
    And I click "Request to Join"
    Then the page contains "Request sent"

  Scenario: Approving a request as the creator
    Given sample requests have been made
    Given I am logged in as "laotzu@dao.ch"
    When I navigate to the specific expedition page
    And I click "Approve"
    Then the page contains "green_tara"

  Scenario: Denying a request as the creator
    Given sample requests have been made
    Given I am logged in as "laotzu@dao.ch"
    When I navigate to the specific expedition page
    And I click "Deny"
    Then the page does not contain "green_tara"

  Scenario: Inviting a friend
    Given sample friendships have been confirmed
    Given I am logged in as "laotzu@dao.ch"
    When I navigate to the specific expedition page
    And I click "Invite Friends"
    And I tick "#journeys_user_ids_" for the user "green_tara"
    And I click "Invite Selected"
    Then I am redirected to the specific expedition page
    And within "#invited" the page contains "green_tara"


