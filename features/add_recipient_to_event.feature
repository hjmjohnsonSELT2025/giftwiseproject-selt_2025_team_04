Feature: I can add a recipient to an event

  Background:
    Given the test user logs in
    Given the test event exists
    Given the test recipient exists
    Then I should see Welcome, capybara
    
  Scenario: 
    When I click More about test event
    When I click Edit
    When I select test from recipient_id
    When I press "commit"
    Then I should see the recipient