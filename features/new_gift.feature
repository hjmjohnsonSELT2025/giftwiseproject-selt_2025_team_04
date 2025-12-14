Feature: I can add gifts to the database

  Background: I am logged in
    Given the test user logs in
    Given the test event exists
    Given the test recipient exists
    Then I should see Welcome, capybara

  Scenario:
    When I click More about test event
    Then I should see "test"
    When I click add a new gift for test
    When I submit my gift info
    Then I should see the new gift assigned to test

  Scenario:
    When I click View all events
    When I click More about test event
    When I click add a new gift for test
    When I submit bad gift info
    Then I should see an error message
