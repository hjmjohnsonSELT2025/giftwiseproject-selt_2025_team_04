Feature: I can generate AI gift suggestions

  Background: I am logged in with a recipient and event
    Given the test user logs in
    And a recipient exists
    And the AI test event exists

  Scenario: Generate AI suggestions for a recipient
    And the AI service returns suggestions
    When I go to the gift suggestions page for the test event and recipient
    And I click View All Events
    And I click View Event
    And I click Generate Ideas
    And I press Generate New Suggestions
    Then I should be on the gift suggestions page
    And I should see "Warriors Signed Basketball"