Feature: I can add gifts to the database

  Background: I am logged in
    Given the test user logs in
    Given the test event exists
    Given the test recipient exists
    Then I should see Welcome, capybara

  Scenario:
    When I click Events
    When I click View Event
    Then I should see "test"
    When I click Add Gift
    When I submit my gift info
    Then I should see the new gift plates
    Then I should see "Idea"

  Scenario:
    When I click Events
    When I click View Event
    When I click Add Gift
    #When I submit bad gift info
    #Then I should see an error message
