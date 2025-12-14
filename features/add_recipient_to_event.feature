Feature: I can add a recipient to an event

  Background:
    Given the test user logs in
    Given the test event exists
    Given the test recipient exists
    Then I should see Welcome, capybara
    
  Scenario:
    When I click View all events
    When I click More about test event
    When I click create a recipient
    Then I should see the recipient