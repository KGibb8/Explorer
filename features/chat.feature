Feature: Chat

  Background:
    Given sample users have been created
    And sample expeditions have been created
    And I am logged in as "shakyamuni@enlightened.being"

  Scenario: Creating a Chat
    When I navigate to the specific expedition page
    And I fill in the "chat[topic]" field with "Equipment"
    And I fill in the "chat[messages_attributes][0][body]" field with "We're looking for climbing equipment"
    And I click "Chat"
    Then I am redirected to the expedition chats page
    And the page contains "Equipment"
    And the page contains "We're looking for climbing equipment"
    And the page contains "shakyamuni"
