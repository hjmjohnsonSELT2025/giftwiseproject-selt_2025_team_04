Feature: I can add a recipient to an event

  Background:
    Given the test user logs in
    Given I click Events
    Given the test event exists
    Then I should see Welcome, capybara
    
  Scenario:
    When I click Events
    When I click View Event
    When I click Create New Recipient
    And I fill out info
    Then I should see the recipient